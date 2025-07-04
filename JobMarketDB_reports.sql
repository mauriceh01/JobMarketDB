-- Maurice Hazan
-- July 3, 2025
-- JobMarketDB_Reports 

USE JobMarketDB;

--  1. Top 10 In-Demand Skills This Month

SELECT s.SkillName, SUM(st.DemandCount) AS TotalDemand
FROM SkillTrends st
JOIN Skills s ON st.SkillID = s.SkillID
WHERE st.SkillMonth = DATE_FORMAT(CURDATE(), '%Y-%m-01')
GROUP BY s.SkillName
ORDER BY TotalDemand DESC
LIMIT 10;

-- 2. Salary Trend for a Given Job Title

SELECT CachedMonth, AVG(AverageSalary) AS AvgSalary
FROM CachedSalaryTrends
WHERE JobTitle = 'Data Analyst'
GROUP BY CachedMonth
ORDER BY CachedMonth;

--  3. AI Job Recommendations for a Specific Job

SELECT jp.JobTitle, jr.Score, jr.Reason
FROM JobRecommendations jr
JOIN JobPostings jp ON jr.RecommendedJobID = jp.JobID
WHERE jr.SourceJobID = 1
ORDER BY jr.Score DESC;

-- 4. Applicant Conversion Funnel

SELECT aps.StageName, COUNT(ap.ApplicationID) AS NumApplicants
FROM ApplicationProgress ap
JOIN ApplicationStages aps ON ap.StageID = aps.StageID
GROUP BY aps.StageOrder, aps.StageName
ORDER BY aps.StageOrder;

-- 5. User Event Heatmap

SELECT EventType, COUNT(*) AS TotalEvents
FROM UserEvents
GROUP BY EventType
ORDER BY TotalEvents DESC;

-- 6. Data Quality Summary

SELECT TableName, AnomalyType, COUNT(*) AS TotalIssues
FROM DataAnomalies
GROUP BY TableName, AnomalyType
ORDER BY TotalIssues DESC;

-- ADMIN DASHBOARD

-- 1. Total Jobs, Applicants, Employers, and Users

SELECT 
  (SELECT COUNT(*) FROM JobPostings) AS TotalJobs,
  (SELECT COUNT(*) FROM Applicants) AS TotalApplicants,
  (SELECT COUNT(*) FROM Employers) AS TotalEmployers,
  (SELECT COUNT(*) FROM Users) AS TotalUsers;
  
-- 2. System Health - Last ETL Run Status

SELECT s.SourceName, e.RunDate, e.RunStatus, e.RecordsExtracted, e.RecordsInserted, e.RecordsFailed
FROM ETLRunLog e
JOIN DataSources s ON e.SourceID = s.SourceID
ORDER BY e.RunDate DESC
LIMIT 5;

-- 3. Top Data Anomalies by Table

SELECT TableName, AnomalyType, COUNT(*) AS IssueCount
FROM DataAnomalies
GROUP BY TableName, AnomalyType
ORDER BY IssueCount DESC
LIMIT 10;

-- ANALYST DASHBOARD
-- Most In-Demand Skills This Month

SELECT s.SkillName, SUM(st.DemandCount) AS Demand
FROM SkillTrends st
JOIN Skills s ON st.SkillID = s.SkillID
WHERE st.SkillMonth = DATE_FORMAT(CURDATE(), '%Y-%m-01')
GROUP BY s.SkillName
ORDER BY Demand DESC
LIMIT 10;

-- Salary Insights by Region and Role

SELECT JobTitle, Location, AVG(AverageSalary) AS AvgSalary
FROM SalaryInsights
WHERE DataMonth = DATE_FORMAT(CURDATE(), '%Y-%m-01')
GROUP BY JobTitle, Location
ORDER BY AvgSalary DESC
LIMIT 10;

-- 3. Monthly Job Postings Trend

SELECT DATE_FORMAT(PostingDate, '%Y-%m') AS Month, COUNT(*) AS JobsPosted
FROM JobPostings
GROUP BY Month
ORDER BY Month DESC
LIMIT 12;

-- EMPLOYER DASHBOARD
-- (Assumes EmployerID = 101 for demo)

-- 1. Active Job Postings

SELECT JobID, JobTitle, Location, PostingDate, ExpirationDate
FROM JobPostings
WHERE EmployerID = 2 AND ExpirationDate >= NOW()
ORDER BY PostingDate DESC;

-- 2. Applications per Job

SELECT jp.JobTitle, COUNT(a.ApplicationID) AS TotalApplications
FROM JobPostings jp
LEFT JOIN Applications a ON a.JobID = jp.JobID
WHERE jp.EmployerID = 1
GROUP BY jp.JobTitle
ORDER BY TotalApplications DESC;

-- 3. Average Rating from Company Reviews

SELECT AVG(Rating) AS AvgRating
FROM CompanyReviews
WHERE EmployerID = 3;

-- JOB SEEKER DASHBOARD
-- (Assumes ApplicantID = 202 for demo)

-- 1. Saved Jobs

SELECT jp.JobTitle, jp.Location, sj.SavedDate
FROM SavedJobs sj
JOIN JobPostings jp ON sj.JobID = jp.JobID
WHERE sj.ApplicantID = 2
ORDER BY sj.SavedDate DESC;

-- 2. Job Applications and Status

SELECT jp.JobTitle, a.ApplicationDate, a.AppStatus
FROM Applications a
JOIN JobPostings jp ON a.JobID = jp.JobID
WHERE a.ApplicantID = 2
ORDER BY a.ApplicationDate DESC;

-- 3. Active Job Alerts

SELECT AlertName, Keywords, Location, Frequency, CreatedAt
FROM JobAlerts
WHERE ApplicantID = 3 AND IsActive = TRUE
ORDER BY CreatedAt DESC;

--  BONUS: AI Insights Module
-- 1. Top AI Recommendations for a Job

SELECT jp.JobTitle AS RecommendedJob, jr.Score, jr.Reason
FROM JobRecommendations jr
JOIN JobPostings jp ON jr.RecommendedJobID = jp.JobID
WHERE jr.SourceJobID = 2
ORDER BY jr.Score DESC
LIMIT 5;

-- 2. AI Feedback Summary

SELECT RecommendationType, COUNT(*) AS TotalFeedback, 
       SUM(CASE WHEN WasHelpful THEN 1 ELSE 0 END) AS HelpfulCount
FROM AIRecommendationFeedback
GROUP BY RecommendationType;

