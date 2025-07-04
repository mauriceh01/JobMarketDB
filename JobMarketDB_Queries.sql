-- Maurice Hazan
-- July 3, 2025
-- JobMarketDB Queries to test the data


USE JobMarketDB;


--  1. Top Performing Jobs by Promotion ROI

SELECT 
    jp.JobID,
    jp.JobTitle,
    SUM(jpr.CostUSD) AS TotalSpent,
    SUM(jpr.Clicks) AS TotalClicks,
    ROUND(SUM(jpr.Clicks) / NULLIF(SUM(jpr.CostUSD), 0), 2) AS ClicksPerDollar
FROM 
    JobPostings jp
JOIN 
    JobPromotions jpr ON jp.JobID = jpr.JobID
GROUP BY 
    jp.JobID, jp.JobTitle
ORDER BY 
    ClicksPerDollar DESC
LIMIT 5;

--  2. Recent Salary Trends (Last 2 Months)

SELECT 
    JobTitle,
    Region,
    CachedMonth,
    AverageSalary,
    SalaryChangePercent
FROM 
    CachedSalaryTrends
WHERE 
    CachedMonth >= '2025-06-01'
ORDER BY 
    JobTitle, CachedMonth;
    
    
--  3. Job Alerts Matching Active Applicants

SELECT 
    ja.ApplicantID,
    a.AppName,
    ja.AlertName,
    ja.Keywords,
    ja.Location,
    ja.MinSalary
FROM 
    JobAlerts ja
JOIN 
    Applicants a ON ja.ApplicantID = a.ApplicantID
WHERE 
    ja.MinSalary > 60000
ORDER BY 
    ja.ApplicantID;
    
-- 4. Widgets Per Dashboard (with Config Preview)


SELECT 
    d.DashboardName,
    w.WidgetType,
    w.PositionOrder,
    w.ConfigJSON
FROM 
    SavedDashboards d
JOIN 
    DashboardWidgets w ON d.DashboardID = w.DashboardID
ORDER BY 
    d.DashboardID, w.PositionOrder;
    
-- 5. AI Recommendations Feedback Summary

SELECT 
    RecommendationType,
    COUNT(*) AS TotalFeedback,
    SUM(CASE WHEN WasHelpful THEN 1 ELSE 0 END) AS HelpfulCount,
    ROUND(AVG(CASE WHEN WasHelpful THEN 1 ELSE 0 END) * 100, 2) AS HelpfulRatePercent
FROM 
    AIRecommendationFeedback
GROUP BY 
    RecommendationType;
    
-- 6. ETL Error Summary

SELECT 
    s.SourceName,
    l.RunDate,
    l.RecordsExtracted,
    l.RecordsInserted,
    l.RecordsFailed,
    l.RunStatus,
    l.Notes
FROM 
    ETLRunLog l
JOIN 
    DataSources s ON l.SourceID = s.SourceID
ORDER BY 
    l.RunDate DESC
LIMIT 5;


--  7. Most Common Skill Co-Occurrences

SELECT 
    s1.SkillName AS Skill1,
    s2.SkillName AS Skill2,
    sc.CoOccurrenceCount
FROM 
    SkillCoOccurrences sc
JOIN 
    Skills s1 ON sc.SkillID1 = s1.SkillID
JOIN 
    Skills s2 ON sc.SkillID2 = s2.SkillID
ORDER BY 
    sc.CoOccurrenceCount DESC
LIMIT 10;

-- 1. Recruiter / Employer Behavior
-- 1.1. Top Employers by Job Post Volume

SELECT 
    e.CompanyName,
    COUNT(j.JobID) AS TotalJobsPosted
FROM 
    Employers e
JOIN 
    JobPostings j ON e.EmployerID = j.EmployerID
GROUP BY 
    e.CompanyName
ORDER BY 
    TotalJobsPosted DESC
LIMIT 5;


-- 1.2. Employers with Failed Payments

SELECT 
    e.CompanyName,
    es.PlanID,
    es.PaymentStatus,
    es.PaymentMethod
FROM 
    Employers e
JOIN 
    EmployerSubscriptions es ON e.EmployerID = es.EmployerID
WHERE 
    es.PaymentStatus = 'Failed';
    
    
-- 1.3. Employer Promotion ROI (Clicks per Dollar)

SELECT 
    e.CompanyName,
    jp.JobTitle,
    SUM(pr.CostUSD) AS TotalSpent,
    SUM(pr.Clicks) AS TotalClicks,
    ROUND(SUM(pr.Clicks) / NULLIF(SUM(pr.CostUSD), 0), 2) AS ClicksPerDollar
FROM 
    Employers e
JOIN 
    JobPostings jp ON e.EmployerID = jp.EmployerID
JOIN 
    JobPromotions pr ON jp.JobID = pr.JobID
GROUP BY 
    e.CompanyName, jp.JobTitle
ORDER BY 
    ClicksPerDollar DESC
LIMIT 10;


--  2. Job Seeker Engagement

-- 2.1. Most Active Applicants by Document Upload

SELECT 
    a.AppName,
    COUNT(d.DocumentID) AS DocumentsUploaded
FROM 
    Applicants a
JOIN 
    ApplicantDocuments d ON a.ApplicantID = d.ApplicantID
GROUP BY 
    a.AppName
ORDER BY 
    DocumentsUploaded DESC
LIMIT 5;


-- 2.2. Applicants with Active Alerts + Subscriptions

SELECT 
    a.AppName,
    COUNT(DISTINCT ja.AlertID) AS Alerts,
    COUNT(DISTINCT es.SubscriptionID) AS Subscriptions
FROM 
    Applicants a
LEFT JOIN 
    JobAlerts ja ON a.ApplicantID = ja.ApplicantID
LEFT JOIN 
    EmailSubscriptions es ON a.ApplicantID = es.UserID
GROUP BY 
    a.AppName
ORDER BY 
    Alerts DESC, Subscriptions DESC;
    
-- 2.3. Interview Feedback Summary

SELECT 
    a.AppName,
    AVG(f.Rating) AS AvgRating,
    COUNT(f.FeedbackID) AS TotalFeedbacks
FROM 
    Applicants a
JOIN 
    Applications ap ON a.ApplicantID = ap.ApplicantID
JOIN 
    InterviewFeedback f ON ap.ApplicationID = f.ApplicationID
GROUP BY 
    a.AppName
ORDER BY 
    AvgRating DESC
LIMIT 5;

--  3. AI/ML Analytics Usage
-- 3.1. Most Helpful AI Recommendations

SELECT 
    JobID,
    COUNT(*) AS TotalRecs,
    SUM(CASE WHEN WasHelpful THEN 1 ELSE 0 END) AS HelpfulCount,
    ROUND(AVG(CASE WHEN WasHelpful THEN 1 ELSE 0 END) * 100, 2) AS HelpfulRate
FROM 
    AIRecommendationFeedback
GROUP BY 
    JobID
ORDER BY 
    HelpfulRate DESC
LIMIT 5;


-- 3.2. Model Performance Overview

SELECT 
    ModelName,
    Version,
    EvaluationDate,
    ROUND(ModelPrecision * 100, 2) AS `Precision`,
    ROUND(Recall * 100, 2) AS `Recall`,
    ROUND(F1Score * 100, 2) AS `F1`,
    Notes
FROM 
    ModelPerformanceMetrics
ORDER BY 
    EvaluationDate DESC;
    
-- 3.3. Normalized Job Titles (ML Cleanup Quality)

SELECT 
    RawTitle,
    StandardTitle,
    ConfidenceScore
FROM 
    NormalizedJobTitles
ORDER BY 
    ConfidenceScore DESC
LIMIT 10;



-- 1. AI/ML Model Performance Analytics
-- Compare latest model versions by F1 score:

SELECT 
    ModelName,
    Version,
    ROUND(F1Score * 100, 2) AS F1_Percent,
    EvaluationDate
FROM 
    ModelPerformanceMetrics
ORDER BY 
    F1Score DESC
LIMIT 5;

-- Precision vs. Recall trend for JobRecommender models:

SELECT 
    ModelName,
    Version,
    ROUND(ModelPrecision * 100, 2) AS 'Precision',
    ROUND(Recall * 100, 2) AS Recall,
    ROUND(F1Score * 100, 2) AS F1,
    EvaluationDate
FROM 
    ModelPerformanceMetrics
WHERE 
    ModelName LIKE 'JobRecommender%'
ORDER BY 
    EvaluationDate DESC;
    
    
--  2. Job Seeker Engagement
--  Most frequently saved job searches:

SELECT 
    Keywords,
    COUNT(*) AS SavedCount
FROM 
    SavedSearches
GROUP BY 
    Keywords
ORDER BY 
    SavedCount DESC
LIMIT 5;

-- Daily vs. Weekly job alerts by users:

SELECT 
    Frequency,
    COUNT(*) AS TotalAlerts
FROM 
    JobAlerts
GROUP BY 
    Frequency
ORDER BY 
    TotalAlerts DESC;
    
--  Positive vs negative AI recommendations:

SELECT 
    RecommendationType,
    SUM(CASE WHEN WasHelpful THEN 1 ELSE 0 END) AS Helpful,
    SUM(CASE WHEN WasHelpful THEN 0 ELSE 1 END) AS NotHelpful
FROM 
    AIRecommendationFeedback
GROUP BY 
    RecommendationType;
    
-- 3. Recruiter / Employer Behavior
-- Top employers by job postings:

SELECT 
    EmployerID,
    SUM(TotalPostings) AS TotalJobsPosted
FROM 
    EmployerMonthlyPostings
GROUP BY 
    EmployerID
ORDER BY 
    TotalJobsPosted DESC
LIMIT 5;

--  Which employers are running the most promotions:

SELECT 
    JobPromotions.JobID,
    Employers.CompanyName,
    COUNT(*) AS PromotionCount
FROM 
    JobPromotions
JOIN 
    JobPostings ON JobPromotions.JobID = JobPostings.JobID
JOIN 
    Employers ON JobPostings.EmployerID = Employers.EmployerID
GROUP BY 
    JobPromotions.JobID
ORDER BY 
    PromotionCount DESC
LIMIT 5;

-- Employer subscription payment success rate:

SELECT 
    PaymentStatus,
    COUNT(*) AS Count
FROM 
    EmployerSubscriptions
GROUP BY 
    PaymentStatus;
    


-- 4. AI/ML Analytics — Deeper Insights
-- Model Precision and Recall over time for each model:

SELECT 
    ModelName,
    Version,
    EvaluationDate,
    ROUND(ModelPrecision * 100, 2) AS 'Precision',
    ROUND(Recall * 100, 2) AS Recall
FROM 
    ModelPerformanceMetrics
ORDER BY 
    ModelName, EvaluationDate ASC;
    
-- Top keywords from job postings with highest frequency:

SELECT 
    Keyword, 
    SUM(Frequency) AS TotalFrequency
FROM 
    JobKeywords
GROUP BY 
    Keyword
ORDER BY 
    TotalFrequency DESC
LIMIT 10;


-- 5. Job Seeker Engagement — User Behavior
-- Applicants with the most documents uploaded:

SELECT 
    ApplicantID,
    COUNT(*) AS DocumentCount
FROM 
    ApplicantDocuments
GROUP BY 
    ApplicantID
ORDER BY 
    DocumentCount DESC
LIMIT 5;


-- Job alerts by employment type distribution:

SELECT 
    EmploymentType,
    COUNT(*) AS AlertCount
FROM 
    JobAlerts
GROUP BY 
    EmploymentType
ORDER BY 
    AlertCount DESC;
    
    
-- Feedback summary count by type:

SELECT 
    FeedbackType,
    COUNT(*) AS Count
FROM 
    UserFeedback
GROUP BY 
    FeedbackType;
    
-- 6. Recruiter / Employer Behavior — Activity & Payments
-- Employers with most active subscriptions:


SELECT 
    EmployerID,
    COUNT(*) AS ActiveSubscriptions
FROM 
    EmployerSubscriptions
WHERE 
    PaymentStatus = 'Active'
GROUP BY 
    EmployerID
ORDER BY 
    ActiveSubscriptions DESC
LIMIT 5;

-- Total invoice amounts by employer:

SELECT 
    EmployerID,
    SUM(AmountUSD) AS TotalSpent
FROM 
    EmployerInvoices
GROUP BY 
    EmployerID
ORDER BY 
    TotalSpent DESC
LIMIT 5;

-- Job promotions effectiveness — calculate CTR (Clicks / Impressions %):

SELECT 
    JobID,
    PromotionType,
    Impressions,
    Clicks,
    ROUND((Clicks / Impressions) * 100, 2) AS CTR_Percentage
FROM 
    JobPromotions
WHERE 
    Impressions > 0
ORDER BY 
    CTR_Percentage DESC
LIMIT 10;

-- 7. Bonus — Data Quality & Anomalies
-- List all detected data anomalies by type:

SELECT 
    AnomalyType,
    COUNT(*) AS Occurrences
FROM 
    DataAnomalies
GROUP BY 
    AnomalyType
ORDER BY 
    Occurrences DESC;
    
-- Most recent data audit changes per table:

SELECT 
    TableName,
    COUNT(*) AS ChangeCount,
    MAX(ChangeTimestamp) AS LastChange
FROM 
    DataAuditLog
GROUP BY 
    TableName
ORDER BY 
    LastChange DESC
LIMIT 10;    

-- 1. Count of applications by job seekers per employer (how active are job seekers per employer's jobs)

SELECT 
    e.CompanyName,
    COUNT(a.ApplicationID) AS TotalApplications
FROM 
    Employers e
LEFT JOIN 
    JobPostings jp ON e.EmployerID = jp.EmployerID
LEFT JOIN 
    Applications a ON jp.JobID = a.JobID
GROUP BY 
    e.CompanyName
ORDER BY 
    TotalApplications DESC;
    
    
-- 2. Number of job postings vs. number of applications per employer (recruiter postings vs seeker engagement)


SELECT
    e.CompanyName,
    COUNT(DISTINCT jp.JobID) AS JobPostings,
    COUNT(a.ApplicationID) AS Applications
FROM 
    Employers e
LEFT JOIN 
    JobPostings jp ON e.EmployerID = jp.EmployerID
LEFT JOIN 
    Applications a ON jp.JobID = a.JobID
GROUP BY
    e.CompanyName
ORDER BY
    JobPostings DESC;
    
-- 3. Active recruiters (employers) by number of job postings in last 30 days vs active job seekers by number of applications


SELECT 
    e.CompanyName,
    COUNT(DISTINCT jp.JobID) AS JobsPostedLast30Days,
    COUNT(DISTINCT a.ApplicantID) AS UniqueApplicantsLast30Days
FROM 
    Employers e
LEFT JOIN 
    JobPostings jp ON e.EmployerID = jp.EmployerID 
       AND jp.PostingDate >= DATE_SUB(CURDATE(), INTERVAL 30 DAY)
LEFT JOIN
    Applications a ON a.JobID = jp.JobID
       AND a.ApplicationDate >= DATE_SUB(CURDATE(), INTERVAL 30 DAY)
GROUP BY 
    e.EmployerID, e.CompanyName
ORDER BY 
    JobsPostedLast30Days DESC
LIMIT 1000;
    
    
-- 4. Number of chat messages initiated by job seekers vs recruiters (engagement volume)

SELECT
    'Applicant' AS SenderType,
    COUNT(cm.MessageID) AS TotalMessages
FROM 
    ChatMessages cm
WHERE 
    cm.SenderType = 'Applicant'

UNION ALL

SELECT
    'Employer' AS SenderType,
    COUNT(cm.MessageID) AS TotalMessages
FROM 
    ChatMessages cm
WHERE 
    cm.SenderType = 'Employer';
    
-- 5. Average number of job applications per job seeker (how engaged seekers are)

SELECT 
    AVG(AppCount) AS AvgApplicationsPerApplicant
FROM (
    SELECT 
        ApplicantID, 
        COUNT(ApplicationID) AS AppCount
    FROM 
        Applications
    GROUP BY 
        ApplicantID
) AS Sub;

    