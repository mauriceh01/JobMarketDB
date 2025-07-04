-- Maurice Hazan
-- July 3, 2025
-- JobMarketDB data inserts 
--

USE JobMarketDB;

INSERT INTO Languages (LanguageCode, LanguageName) VALUES
('en', 'English'),
('es', 'Spanish'),
('fr', 'French'),
('de', 'German'),
('zh', 'Chinese'),
('hi', 'Hindi'),
('ar', 'Arabic');

INSERT INTO JobCategories (CategoryName) VALUES
('Software Engineering'),
('Data Science'),
('Marketing'),
('Sales'),
('Customer Support'),
('Product Management'),
('Finance'),
('Operations'),
('Software Development'),
('Data & Analytics'),
('Education & Training');


INSERT INTO JobCategoryMap (JobID, CategoryID) VALUES
(1, 1), -- Backend Developer → Software Development
(2, 2), -- Data Analyst → Data & Analytics
(3, 3), -- Marketing Automation → Marketing
(4, 4), -- Financial Analyst → Finance
(5, 5); -- Learning Designer → Education & Training

INSERT INTO Skills (SkillName) VALUES
('Python'),
('SQL'),
('Java'),
('JavaScript'),
('Excel'),
('Project Management'),
('AWS'),
('Docker'),
('Communication'),
('Machine Learning'),
('Tableau'),
('HTML/CSS'),
('CRM Tools'),
('Financial Modeling'),
('Instructional Design');

INSERT INTO JobSkills (JobID, SkillID, SkillLevel) VALUES
(1, 1, 'Expert'), -- Python
(1, 2, 'Intermediate'), -- SQL
(1, 3, 'Intermediate'), -- Flask
(2, 2, 'Advanced'), -- SQL
(2, 4, 'Advanced'), -- Excel
(2, 5, 'Intermediate'), -- Tableau
(3, 8, 'Advanced'), -- CRM Tools
(3, 6, 'Intermediate'), -- JavaScript
(3, 7, 'Intermediate'), -- HTML/CSS
(4, 9, 'Advanced'), -- Financial Modeling
(4, 4, 'Advanced'), -- Excel
(5, 10, 'Expert'), -- Instructional Design
(5, 7, 'Beginner'); -- HTML/CSS


INSERT INTO ApplicationStages (StageOrder, StageName) VALUES
(1, 'Submitted'),
(2, 'Phone Screen'),
(3, 'Interview'),
(4, 'Offer'),
(5, 'Hired'),
(6, 'Rejected');

INSERT INTO NotificationTemplates (NotificationType, SubjectTemplate, BodyTemplate) VALUES
('NewJobMatch', 'New job match for you: {{JobTitle}}', 'We found a job that matches your profile. Check out: {{JobLink}}'),
('SalaryAlert', 'Salary Trend Update: {{JobTitle}}', 'The average salary for {{JobTitle}} has changed in your region.');

INSERT INTO PricingPlans (PlanName, Description, PriceUSD, MaxJobPostings, DurationDays, IncludesPromotions) VALUES
('Starter', 'Post up to 5 jobs/month', 49.99, 5, 30, FALSE),
('Standard', 'Post up to 25 jobs/month with promotion options', 199.99, 25, 30, TRUE),
('Enterprise', 'Unlimited postings + analytics dashboard', 499.99, 9999, 30, TRUE);

INSERT INTO Employers (FoundedYear, CompanyName, Industry, Website, Headquarters, CompanySize, GlassdoorRating) VALUES
(2003, 'TechNova Inc.', 'Software', 'https://www.technova.com', 'San Francisco, CA', '201–500', 4.2),
(1998, 'HealthBridge', 'Healthcare', 'https://www.healthbridge.org', 'Chicago, IL', '501–1000', 3.9),
(2010, 'MarketWorks', 'Marketing', 'https://www.marketworks.co', 'New York, NY', '51–200', 4.5),
(2005, 'FinTrust Capital', 'Finance', 'https://www.fintrust.com', 'Boston, MA', '1001–5000', 4.0),
(2016, 'EduSphere', 'EdTech', 'https://www.edusphere.edu', 'Austin, TX', '11–50', 4.7);

INSERT INTO Locations (City, State, Country, Latitude, Longitude) VALUES
('San Francisco', 'CA', 'USA', 37.7749, -122.4194),
('Chicago', 'IL', 'USA', 41.8781, -87.6298),
('New York', 'NY', 'USA', 40.7128, -74.0060),
('Boston', 'MA', 'USA', 42.3601, -71.0589),
('Austin', 'TX', 'USA', 30.2672, -97.7431);

INSERT INTO JobPostings (
    EmployerID, LocationID, Currency, JobTitle, JobDescription, EmploymentType,
    Location, RemoteOption, SalaryMin, SalaryMax, PostingDate, ExpirationDate, JobSource
) VALUES
(1, 1, 'USD', 'Backend Developer', 'Develop APIs and microservices in Python and Flask.', 'Full-Time', 'San Francisco, CA', TRUE, 110000, 140000, NOW(), DATE_ADD(NOW(), INTERVAL 30 DAY), 'TechNova Careers'),

(2, 2, 'USD', 'Healthcare Data Analyst', 'Analyze patient and treatment data for hospital networks.', 'Full-Time', 'Chicago, IL', FALSE, 75000, 95000, NOW(), DATE_ADD(NOW(), INTERVAL 30 DAY), 'LinkedIn'),

(3, 3, 'USD', 'Marketing Automation Specialist', 'Manage email campaigns and CRM integrations.', 'Contract', 'New York, NY', TRUE, 60000, 80000, NOW(), DATE_ADD(NOW(), INTERVAL 45 DAY), 'MarketWorks Website'),

(4, 4, 'USD', 'Financial Analyst', 'Build financial models and forecasting dashboards.', 'Full-Time', 'Boston, MA', FALSE, 85000, 100000, NOW(), DATE_ADD(NOW(), INTERVAL 60 DAY), 'Indeed'),

(5, 5, 'USD', 'Learning Experience Designer', 'Design digital learning content using Articulate and Canva.', 'Part-Time', 'Austin, TX', TRUE, 50000, 70000, NOW(), DATE_ADD(NOW(), INTERVAL 30 DAY), 'EduSphere Careers');

INSERT INTO Applicants (AppName, Location, CurrentTitle, YearsExperience, EducationLevel) VALUES
('Alice Johnson', 'San Francisco, CA', 'Software Engineer', 4.5, 'Bachelor\'s Degree'),
('Brian Kim', 'Chicago, IL', 'Data Analyst', 2.0, 'Master\'s Degree'),
('Carla Rivera', 'New York, NY', 'Marketing Associate', 3.0, 'Bachelor\'s Degree'),
('Daniel Osei', 'Boston, MA', 'Finance Associate', 5.0, 'MBA'),
('Emma Singh', 'Austin, TX', 'Instructional Designer', 6.0, 'Master\'s Degree');

INSERT INTO Applications (JobID, ApplicantID, ApplicationDate, AppStatus) VALUES
(1, 1, NOW(), 'Submitted'),
(2, 2, NOW(), 'Interviewed'),
(3, 3, NOW(), 'Submitted'),
(4, 4, NOW(), 'Hired'),
(5, 5, NOW(), 'Submitted');


INSERT INTO Currencies (CurrencyCode, CurrencyName, Symbol, DecimalPrecision) VALUES
('USD', 'United States Dollar', '$', 2),
('EUR', 'Euro', '€', 2),
('JPY', 'Japanese Yen', '¥', 0),
('GBP', 'British Pound Sterling', '£', 2),
('AUD', 'Australian Dollar', 'A$', 2),
('CAD', 'Canadian Dollar', 'C$', 2),
('CHF', 'Swiss Franc', 'Fr', 2),
('CNY', 'Chinese Yuan Renminbi', '¥', 2),
('SEK', 'Swedish Krona', 'kr', 2),
('NZD', 'New Zealand Dollar', 'NZ$', 2),
('MXN', 'Mexican Peso', '$', 2),
('SGD', 'Singapore Dollar', 'S$', 2),
('HKD', 'Hong Kong Dollar', 'HK$', 2),
('NOK', 'Norwegian Krone', 'kr', 2),
('KRW', 'South Korean Won', '₩', 0),
('TRY', 'Turkish Lira', '₺', 2),
('INR', 'Indian Rupee', '₹', 2),
('RUB', 'Russian Ruble', '₽', 2),
('ZAR', 'South African Rand', 'R', 2),
('BRL', 'Brazilian Real', 'R$', 2);

INSERT INTO SkillTrends (SkillID, DemandCount, SkillMonth) VALUES
(1, 120, '2025-05-01'), -- Python
(1, 135, '2025-06-01'),
(1, 142, '2025-07-01'),

(2, 98, '2025-06-01'), -- SQL
(2, 105, '2025-07-01'),

(5, 30, '2025-06-01'), -- Tableau
(5, 33, '2025-07-01');

INSERT INTO SalaryInsights (SampleSize, JobTitle, Location, AverageSalary, MedianSalary, MinSalary, MaxSalary, DataMonth) VALUES
(47, 'Backend Developer', 'San Francisco, CA', 125000, 123000, 110000, 140000, '2025-07-01'),
(35, 'Healthcare Data Analyst', 'Chicago, IL', 87000, 85000, 75000, 95000, '2025-07-01'),
(22, 'Marketing Automation Specialist', 'New York, NY', 72000, 70000, 60000, 80000, '2025-07-01'),
(31, 'Financial Analyst', 'Boston, MA', 95000, 94000, 85000, 100000, '2025-07-01'),
(18, 'Learning Experience Designer', 'Austin, TX', 61000, 60000, 50000, 70000, '2025-07-01');


INSERT INTO Certifications (CertificationName, IssuingAuthority, Description) VALUES
('AWS Certified Solutions Architect', 'Amazon Web Services', 'Cloud architecture and infrastructure design'),
('Google Data Analytics Certificate', 'Google', 'Entry-level data analysis with tools like Excel and SQL'),
('Certified Financial Analyst (CFA)', 'CFA Institute', 'Financial analysis and investment decision-making'),
('Instructional Design Pro', 'ID Academy', 'Online course design and e-learning tools');

INSERT INTO JobCertifications (JobID, CertificationID, RequiredOrPreferred) VALUES
(1, 1, 'Preferred'),
(2, 2, 'Required'),
(4, 3, 'Required'),
(5, 4, 'Preferred');

INSERT INTO EducationRequirements (JobID, EducationLevel, IsRequired) VALUES
(1, 'Bachelor\'s Degree', TRUE),
(2, 'Bachelor\'s Degree', TRUE),
(2, 'Master\'s Degree', FALSE),
(3, 'Bachelor\'s Degree', TRUE),
(4, 'Master\'s Degree', TRUE),
(5, 'Master\'s Degree', TRUE);

INSERT INTO JobBenefits (JobID, Benefit) VALUES
(1, '401(k)'),
(1, 'Health Insurance'),
(1, 'Remote Work'),
(2, 'Health Insurance'),
(2, 'Dental Insurance'),
(3, 'Remote Work'),
(3, 'Paid Time Off'),
(4, '401(k)'),
(4, 'Health Insurance'),
(5, 'Flexible Hours'),
(5, 'Remote Work');


INSERT INTO JobTrends (TotalPostings, JobTitle, Location, JobMonth, RemotePercentage) VALUES
(125, 'Backend Developer', 'San Francisco, CA', '2025-07-01', 65.0),
(98, 'Healthcare Data Analyst', 'Chicago, IL', '2025-07-01', 25.0),
(57, 'Marketing Automation Specialist', 'New York, NY', '2025-07-01', 70.0),
(74, 'Financial Analyst', 'Boston, MA', '2025-07-01', 10.0),
(43, 'Learning Experience Designer', 'Austin, TX', '2025-07-01', 90.0);


INSERT INTO TopSkillsByRegion (Region, SkillID, DemandCount, TopRank, LastUpdated) VALUES
('San Francisco, CA', 1, 120, 1, NOW()), -- Python
('San Francisco, CA', 3, 95, 2, NOW()),  -- Flask
('Chicago, IL', 2, 98, 1, NOW()),        -- SQL
('New York, NY', 8, 78, 1, NOW()),       -- CRM Tools
('Boston, MA', 9, 88, 1, NOW()),         -- Financial Modeling
('Austin, TX', 10, 67, 1, NOW());        -- Instructional Design



INSERT INTO SavedJobs (ApplicantID, JobID, SavedDate) VALUES
(1, 1, NOW()),
(2, 2, NOW()),
(3, 3, NOW()),
(5, 5, NOW());

INSERT INTO UserEvents (UserID, EventType, EventDescription, PageURL) VALUES
(1, 'ViewedJob', 'Viewed job: Backend Developer', '/jobs/1'),
(2, 'Applied', 'Applied to Healthcare Data Analyst', '/jobs/2'),
(3, 'SavedSearch', 'Saved a search for marketing jobs', '/search?category=Marketing'),
(1, 'FilteredBySkill', 'Filtered by skill: Python', '/search?skill=Python');

INSERT INTO UserJourney (ApplicantID, Stage, JobID, Timestamp, Notes) VALUES
(1, 'Search', 1, NOW(), 'Looked for developer roles'),
(1, 'View', 1, NOW(), 'Viewed Backend Developer listing'),
(1, 'Save', 1, NOW(), 'Saved job'),
(2, 'Search', 2, NOW(), 'Looked for analyst jobs'),
(2, 'Apply', 2, NOW(), 'Submitted application');

INSERT INTO Users (PreferredLanguage, Username, PasswordHash, Email, FullName, Role) VALUES
('en', 'admin_jane', 'hashed_password_1', 'jane@jobmarketdb.com', 'Jane Doe', 'Admin'),
('en', 'analyst_mike', 'hashed_password_2', 'mike@jobmarketdb.com', 'Mike Rivera', 'Analyst'),
('en', 'recruiter_sara', 'hashed_password_3', 'sara@techcorp.com', 'Sara Lin', 'Recruiter');


INSERT INTO LoginAuditLog (UserID, LoginTimestamp, IPAddress, DeviceInfo, Success) VALUES
(1, NOW(), '192.168.1.10', 'Chrome on Windows 10', TRUE),
(2, NOW(), '192.168.1.20', 'Firefox on MacOS', TRUE),
(3, NOW(), '192.168.1.30', 'Safari on iOS', TRUE);

-- Tags
INSERT INTO JobTags (TagName, Description) VALUES
('Urgent Hire', 'Company needs to fill this position quickly'),
('Remote Friendly', 'Offers flexible remote options'),
('Internship', 'Open to students or recent graduates');

-- Tag mappings (tag job listings)
INSERT INTO JobTagMap (JobID, TagID, TaggedBy, TagDate) VALUES
(1, 1, 2, NOW()),  -- Analyst tags Backend Dev as Urgent
(2, 2, 2, NOW()),  -- Analyst tags Analyst job as Remote Friendly
(3, 2, 3, NOW());  -- Recruiter tags Marketing role as Remote


INSERT INTO JobAnnotations (JobID, AnnotatedBy, AnnotationText, AnnotatedAt) VALUES
(1, 2, 'This position requires further clarification on backend tech stack.', NOW()),
(2, 3, 'Consider rephrasing the qualifications to attract more applicants.', NOW()),
(3, 2, 'Good candidate flow. Leave as-is.', NOW());

-- Dashboards
INSERT INTO SavedDashboards (UserID, DashboardName, ConfigJSON, CreatedAt) VALUES
(1, 'Executive Summary', '{"layout":"grid","theme":"dark"}', NOW()),
(2, 'Skill Demand Heatmap', '{"filters":["skill","region"]}', NOW());

-- Widgets for dashboard 1
INSERT INTO DashboardWidgets (DashboardID, WidgetType, PositionOrder, ConfigJSON) VALUES
 (1, 'KPI_Cards', 1, '{"metric":"total_jobs"}'),
 (1, 'LineChart', 2, '{"dataSource":"JobTrends"}'),

-- Widgets for dashboard 2
(2, 'Map', 1, '{"metric":"TopSkillsByRegion"}'),
(2, 'BarChart', 2, '{"x":"Skill","y":"DemandCount"}'); 	


INSERT INTO JobSearchIndex (JobID, IndexedTitle, IndexedDescription, IndexedSkills) VALUES
(1, 'Backend Developer', 'Develop APIs and microservices in Python and Flask.', 'Python, SQL, Flask'),
(2, 'Healthcare Data Analyst', 'Analyze patient and treatment data.', 'SQL, Excel, Tableau'),
(3, 'Marketing Automation Specialist', 'Manage campaigns and CRM systems.', 'CRM Tools, JavaScript, HTML'),
(4, 'Financial Analyst', 'Financial modeling and forecasting.', 'Excel, Financial Modeling'),
(5, 'Learning Experience Designer', 'Design online learning content.', 'Instructional Design, HTML');

INSERT INTO JobRecommendations (SourceJobID, RecommendedJobID, Score, Reason) VALUES
(1, 2, 0.65, 'Similar data-focused roles'),
(1, 3, 0.55, 'CRM and backend overlap'),
(2, 1, 0.70, 'Technical analysis overlap'),
(3, 5, 0.50, 'Both involve user experience and content'),
(4, 2, 0.45, 'Analytical role match');

INSERT INTO JobPromotions (JobID, PromotionType, StartDate, EndDate, CostUSD, Impressions, Clicks) VALUES
-- Backend Developer (JobID 1)
(1, 'Featured', '2025-06-15', '2025-07-15', 199.99, 12000, 480),
(1, 'Homepage', '2025-06-20', '2025-07-05', 149.99, 8000, 300),

-- Healthcare Data Analyst (JobID 2)
(2, 'Email Blast', '2025-07-01', '2025-07-10', 99.99, 5000, 125),
(2, 'Sponsored', '2025-07-03', '2025-07-17', 179.99, 9500, 290),

-- Marketing Automation Specialist (JobID 3)
(3, 'Highlighted', '2025-07-01', '2025-07-14', 89.99, 4000, 110),

-- Financial Analyst (JobID 4)
(4, 'Featured', '2025-06-28', '2025-07-28', 199.99, 10000, 375),

-- Learning Experience Designer (JobID 5)
(5, 'Homepage', '2025-07-01', '2025-07-21', 149.99, 6200, 185);



INSERT INTO CachedSalaryTrends (
    JobID, JobTitle, Region, CachedMonth, AverageSalary, SalaryChangePercent, JobCount, LastUpdated
) VALUES
-- Backend Developer (JobID 1)
(1, 'Backend Developer', 'San Francisco, CA', '2025-06-01', 123000.00, 2.5, 118, NOW()),
(1, 'Backend Developer', 'San Francisco, CA', '2025-07-01', 125000.00, 1.6, 125, NOW()),

-- Healthcare Data Analyst (JobID 2)
(2, 'Healthcare Data Analyst', 'Chicago, IL', '2025-06-01', 85000.00, 0.0, 95, NOW()),
(2, 'Healthcare Data Analyst', 'Chicago, IL', '2025-07-01', 87000.00, 2.4, 98, NOW()),

-- Marketing Automation Specialist (JobID 3)
(3, 'Marketing Automation Specialist', 'New York, NY', '2025-06-01', 69000.00, -1.4, 54, NOW()),
(3, 'Marketing Automation Specialist', 'New York, NY', '2025-07-01', 72000.00, 4.3, 57, NOW()),

-- Financial Analyst (JobID 4)
(4, 'Financial Analyst', 'Boston, MA', '2025-06-01', 94000.00, 1.1, 70, NOW()),
(4, 'Financial Analyst', 'Boston, MA', '2025-07-01', 95000.00, 1.0, 74, NOW()),

-- Learning Experience Designer (JobID 5)
(5, 'Learning Experience Designer', 'Austin, TX', '2025-06-01', 60000.00, 0.0, 41, NOW()),
(5, 'Learning Experience Designer', 'Austin, TX', '2025-07-01', 61000.00, 1.7, 43, NOW());



INSERT INTO JobAlerts (
    ApplicantID, AlertName, Keywords, Location, MinSalary, EmploymentType, Frequency
) VALUES
(1, 'Python Dev in SF', 'Python,Backend', 'San Francisco, CA', 100000.00, 'Full-Time', 'Daily'),
(2, 'Data Jobs Chicago', 'Data Analyst,SQL', 'Chicago, IL', 80000.00, 'Full-Time', 'Weekly'),
(3, 'Remote Marketing', 'CRM,Marketing', 'Remote', 60000.00, 'Contract', 'Instant');


INSERT INTO CompanyReviews (EmployerID, ReviewerName, ReviewDate, Rating, Pros, Cons, ReviewTitle)
VALUES
(1, 'Michael T.', '2025-06-10', 4.5, 'Great engineering culture and flexible hours.', 'Occasional long hours during release cycles.', 'Great place to grow!'),
(2, 'Sandra L.', '2025-06-15', 3.8, 'Supportive team, good benefits.', 'Management changes frequently.', 'Solid healthcare company'),
(3, 'David R.', '2025-06-18', 4.7, 'Creative freedom in campaigns.', 'Fast-paced and sometimes chaotic.', 'Exciting marketing team'),
(4, 'Linda G.', '2025-06-22', 4.2, 'Good compensation and clear career path.', 'A bit rigid in workflow.', 'Stable finance firm'),
(5, 'Nina P.', '2025-06-25', 4.9, 'Awesome team, flexible hours, meaningful work.', 'Limited upward mobility in small teams.', 'Great for educators');


-- EmailSubscriptions
INSERT INTO EmailSubscriptions (UserID, SubscriptionType, Email, SubscribedDate, IsActive) VALUES
(1, 'Job Alerts', 'jane@jobmarketdb.com', '2025-06-01 09:15:00', TRUE),
(2, 'Newsletter', 'mike@jobmarketdb.com', '2025-05-20 14:30:00', TRUE),
(3, 'Promotions', 'sara@techcorp.com', '2025-06-15 08:45:00', FALSE),
(1, 'Newsletter', 'jane@jobmarketdb.com', '2025-06-10 11:00:00', TRUE);

-- ApplicantDocuments
INSERT INTO ApplicantDocuments (ApplicantID, DocumentType, DocumentName, DocumentPath, UploadDate) VALUES
(1, 'Resume', 'Alice_Johnson_Resume.pdf', '/uploads/resumes/Alice_Johnson_Resume.pdf', '2025-06-25 13:20:00'),
(1, 'Cover Letter', 'Alice_Johnson_CoverLetter.pdf', '/uploads/coverletters/Alice_Johnson_CoverLetter.pdf', '2025-06-25 13:30:00'),
(2, 'Resume', 'Brian_Kim_Resume.pdf', '/uploads/resumes/Brian_Kim_Resume.pdf', '2025-06-26 10:00:00'),
(3, 'Certificate', 'Marketing_Certification.pdf', '/uploads/certificates/Marketing_Certification.pdf', '2025-06-27 09:45:00');

-- InterviewFeedback
INSERT INTO InterviewFeedback (ApplicationID, InterviewerName, InterviewDate, FeedbackText, Rating, CreatedAt) VALUES
(1, 'John Smith', '2025-06-28', 'Strong technical skills and good problem solving. Recommended for next round.', 4.5, '2025-06-28 15:00:00'),
(2, 'Mary Johnson', '2025-06-29', 'Good communication, but needs more experience with large datasets.', 3.8, '2025-06-29 16:30:00'),
(3, 'David Lee', '2025-06-30', 'Excellent understanding of CRM platforms. Very motivated candidate.', 4.7, '2025-06-30 14:00:00'),
(5, 'Susan Clark', '2025-07-01', 'Creative and detail-oriented. Would be a great asset to the team.', 4.3, '2025-07-01 11:15:00');



INSERT INTO ApplicationProgress (ApplicationID, StageID, UpdatedAt, Notes) VALUES
(1, 1, '2025-06-28 20:52:15', 'Application received'),
(1, 2, '2025-06-29 20:52:15', 'Resume reviewed'),
(1, 3, '2025-07-01 20:52:15', 'Interview completed');

INSERT INTO AIRecommendationFeedback (UserID, JobID, RecommendationType, WasHelpful, Comments, Timestamp) VALUES
(1, 1, 'SkillMatch', TRUE, 'Great match for SQL skills', '2025-06-30 20:52:15'),
(2, 2, 'SimilarJob', FALSE, 'Role was unrelated to experience', '2025-07-01 20:52:15'),
(3, 3, 'SkillMatch', TRUE, 'Loved the alignment with Python', '2025-07-02 20:52:15');

INSERT INTO ApiClients (ClientName, ContactEmail, IsActive, CreatedAt) VALUES
('TalentFinder', 'api@talentfinder.com', TRUE, '2025-06-03 20:52:15'),
('SmartHireAI', 'dev@smarthire.ai', TRUE, '2025-06-13 20:52:15'),
('JobBridge', 'contact@jobbridge.org', FALSE, '2025-06-23 20:52:15');


INSERT INTO ApiTokens (ClientID, Token, Expiration, Scope, IsRevoked, CreatedAt) VALUES
(1, 'd6327986-7021-410a-af98-c900602db480', '2025-12-30 20:52:15', 'read_jobs', FALSE, '2025-06-03 20:52:15'),
(2, 'dfa1a946-389a-4270-b10f-2c42dcdc79f9', '2025-10-01 20:52:15', 'post_jobs', FALSE, '2025-06-13 20:52:15'),
(3, '2eb07c20-b505-4f63-857e-5053f035a21f', '2025-09-01 20:52:15', 'read_jobs', TRUE, '2025-06-23 20:52:15');


INSERT INTO ApplicantDemographics (ApplicantID, Gender, Ethnicity, DisabilityStatus, VeteranStatus, Disclosed) VALUES
(1, 'Male', 'Hispanic', 'No', 'No', TRUE),
(2, 'Female', 'Asian', 'No', 'Yes', TRUE),
(3, 'Non-Binary', 'White', 'Yes', 'No', TRUE);

INSERT INTO ArchivedJobPostings (OriginalJobID, EmployerID, JobTitle, ArchivedAt, Reason) VALUES
(1, 1, 'Data Analyst', '2025-06-23 20:52:15', 'Position filled'),
(2, 2, 'DevOps Engineer', '2025-06-26 20:52:15', 'Expired'),
(3, 1, 'Product Manager', '2025-06-30 20:52:15', 'Repost with updates');

INSERT INTO ChatThreads (ApplicantID, EmployerID, JobID, CreatedAt) VALUES
(1, 1, 1, '2025-06-28 20:57:13'),
(2, 2, 2, '2025-06-30 20:57:13'),
(3, 1, 3, '2025-07-02 20:57:13');


INSERT INTO ChatMessages (ThreadID, SenderID, MessageText, SenderType, SentAt) VALUES
(1, 1, 'Hello, I am very interested in the Data Analyst position.', 'Applicant', '2025-06-28 17:57:13'),
(1, 101, 'Thanks for reaching out. Can you share your resume?', 'Employer', '2025-06-28 18:57:13'),
(2, 2, 'Can you provide more details on the remote policy?', 'Applicant', '2025-06-30 16:57:13'),
(2, 102, 'Sure, the role is hybrid with two days remote.', 'Employer', '2025-06-30 17:57:13'),
(3, 3, 'Is there flexibility with the start date?', 'Applicant', '2025-07-02 15:57:13');


INSERT INTO DataAnomalies (TableName, RecordID, AnomalyType, DetectedAt, Notes) VALUES
('JobPostings', 101, 'Outlier Salary', '2025-06-29 20:57:13', 'Salary listed as 1,000,000 for entry-level role'),
('Skills', 56, 'NULL Skill Name', '2025-07-01 20:57:13', 'Missing skill name in record'),
('Applicants', 3, 'Invalid Experience Value', '2025-07-02 20:57:13', 'Experience listed as -5 years');


INSERT INTO DataAuditLog (TableName, RecordID, ChangedBy, ChangeType, ChangeTimestamp, OldValue, NewValue) VALUES
('Users', 201, 1, 'UPDATE', '2025-06-30 20:57:13', 'Role: Recruiter', 'Role: Admin'),
('JobPostings', 305, 2, 'DELETE', '2025-07-01 20:57:13', 'JobTitle: Python Dev', NULL),
('Employers', 88, 1, 'INSERT', '2025-07-02 20:57:13', NULL, 'CompanyName: NewTech Inc.');



INSERT INTO DataConsentLog (UserID, ConsentType, ConsentGivenAt, ConsentMethod) VALUES
(1, 'GDPR', '2025-06-27 20:57:13', 'Checkbox'),
(2, 'CCPA', '2025-06-29 20:57:13', 'Digital Signature'),
(3, 'EmailMarketing', '2025-07-01 20:57:13', 'Checkbox');

INSERT INTO DataSources (SourceName, BaseURL, Description) VALUES
('Indeed', 'https://api.indeed.com', 'Mainstream job board API'),
('LinkedIn', 'https://www.linkedin.com/jobs', 'Job scraping from LinkedIn postings'),
('Dice', 'https://www.dice.com', 'Tech jobs board integration');

-- DeletedRecords
INSERT INTO DeletedRecords (RecordID, DeletedBy, TableName, DeletedAt, Reason) VALUES
(501, 1, 'JobPostings', '2025-07-03 21:02:11', 'Expired job posting cleanup'),
(202, 2, 'Applicants', '2025-07-03 21:02:11', 'Requested deletion by user'),
(88, 3, 'EmployerReviews', '2025-07-03 21:02:11', 'Inappropriate content flagged');

-- EmployerCompetitors
INSERT INTO EmployerCompetitors (EmployerID, CompetitorID, Region) VALUES
(1, 2, 'San Francisco Bay Area'),
(3, 4, 'New York City'),
(5, 6, 'Austin, TX');

-- EmployerInvoices
INSERT INTO EmployerInvoices (EmployerID, InvoiceDate, AmountUSD, Description, Paid, PaymentDate, PaymentMethod) VALUES
(1, '2025-06-01', 299.99, 'Monthly subscription plan', TRUE, '2025-06-02', 'Credit Card'),
(2, '2025-06-15', 499.00, 'Featured job promotions', FALSE, NULL, 'Bank Transfer'),
(3, '2025-07-01', 199.99, 'Basic job posting package', TRUE, '2025-07-01', 'PayPal');

-- EmployerMonthlyPostings
INSERT INTO EmployerMonthlyPostings (EmployerID, Region, EmployerMonth, TotalPostings) VALUES
(1, 'San Francisco Bay Area', '2025-06-01', 12),
(2, 'New York City', '2025-06-01', 8),
(3, 'Austin, TX', '2025-06-01', 5);

-- EmployerReviews
INSERT INTO EmployerReviews (EmployerID, ReviewTitle, ReviewText, Rating, ReviewDate, ReviewerTitle, Location) VALUES
(1, 'Great Culture', 'Enjoyed working with a collaborative and inclusive team.', 4.5, '2025-06-10', 'Software Engineer', 'San Francisco, CA'),
(2, 'Fast-paced Environment', 'Challenging but rewarding work. Expect long hours.', 3.8, '2025-06-12', 'Product Manager', 'New York, NY'),
(3, 'Supportive Leadership', 'Managers were always helpful and understanding.', 4.7, '2025-06-15', 'Data Analyst', 'Austin, TX');


INSERT INTO EmployerSubscriptions (EmployerID, PlanID, StartDate, EndDate, PaymentMethod, PaymentStatus) VALUES
(1, 1, '2025-06-01', '2025-07-01', 'Credit Card', 'Active'),
(2, 2, '2025-06-15', '2025-07-15', 'PayPal', 'Failed'),
(3, 3, '2025-07-01', '2025-08-01', 'Bank Transfer', 'Active');

INSERT INTO ETLRunLog (SourceID, RunDate, RecordsExtracted, RecordsInserted, RecordsFailed, RunStatus, Notes) VALUES
(1, '2025-07-03 21:19:05', 500, 480, 20, 'Partial', 'Some records had missing fields'),
(2, '2025-07-03 21:19:05', 300, 300, 0, 'Success', 'Clean run'),
(3, '2025-07-03 21:19:05', 0, 0, 0, 'Failed', 'Source not reachable');


-- GlobalKeywordTrends
INSERT INTO GlobalKeywordTrends (Keyword, GlobalMonth, Frequency, GlobalRank) VALUES
('Python', '2025-06-01', 1250, 1),
('SQL', '2025-06-01', 1000, 2),
('AWS', '2025-06-01', 850, 3);

-- JobCredits
INSERT INTO JobCredits (EmployerID, CreditsAvailable, CreditsUsed, LastUpdated) VALUES
(1, 10, 2, '2025-07-03 21:19:05'),
(2, 5, 5, '2025-07-03 21:19:05'),
(3, 20, 10, '2025-07-03 21:19:05');

-- JobEEOInfo
INSERT INTO JobEEOInfo (JobID, IsEEOCompliant, DiversityStatement, MinorityRecruiting) VALUES
(1, TRUE, 'We are committed to diversity and inclusion in the workplace.', TRUE),
(2, FALSE, NULL, FALSE),
(3, TRUE, 'Equal opportunity employer.', TRUE);

-- JobImportSources
INSERT INTO JobImportSources (SourceName, SourceType, EndpointURL, AuthMethod, Description) VALUES
('Indeed API', 'API', 'https://api.indeed.com/jobs', 'API Key', 'Daily job scraping from Indeed'),
('LinkedIn Scraper', 'Scraper', 'https://linkedin.com/jobs', 'None', 'Web scraping of LinkedIn job posts'),
('RSSFeedParser', 'RSS', 'https://example.com/jobs/rss', 'None', 'RSS job feed parser');

-- JobImportLogs
INSERT INTO JobImportLogs (SourceID, StartTime, EndTime, JobsFound, JobsInserted, JobImportErrors, JobImportStatus, Notes) VALUES
(1, '2025-07-03 21:19:05', '2025-07-03 21:19:05', 200, 180, 20, 'Partial', 'Parsing errors on 20 records'),
(2, '2025-07-03 21:19:05', '2025-07-03 21:19:05', 300, 300, 0, 'Success', 'Smooth import'),
(3, '2025-07-03 21:19:05', '2025-07-03 21:19:05', 0, 0, 0, 'Failed', 'Invalid RSS format');

-- JobKeywords
INSERT INTO JobKeywords (JobID, Keyword, Frequency, IsTechnical) VALUES
(1, 'Python', 10, TRUE),
(1, 'Teamwork', 5, FALSE),
(2, 'SQL', 8, TRUE),
(3, 'Leadership', 6, FALSE);


INSERT INTO ModelPerformanceMetrics (ModelName, Version, EvaluationDate, ModelPrecision, Recall, F1Score, Notes) VALUES
('JobRecommenderV1', '1.0', '2025-06-25', 0.8721, 0.8115, 0.8409, 'Baseline model after tuning'),
('JobRecommenderV2', '2.0', '2025-07-01', 0.9134, 0.8552, 0.8834, 'Incorporated NLP embeddings'),
('JobClassifierML', '1.3', '2025-06-15', 0.7890, 0.7450, 0.7664, 'Used traditional TF-IDF');

INSERT INTO NormalizedJobTitles (RawTitle, StandardTitle, ConfidenceScore, CreatedAt) VALUES
('Sr. Software Eng.', 'Senior Software Engineer', 0.95, '2025-07-01 10:00:00'),
('Jr Data Analyst', 'Junior Data Analyst', 0.89, '2025-07-01 10:01:00'),
('DevOps Guru', 'DevOps Engineer', 0.80, '2025-07-01 10:02:00');


INSERT INTO QAJobs (CreatedBy, Title, QAStatus, CreatedAt) VALUES
(1, 'Data Import Job QA Test', 'Pending', '2025-07-03 12:00:00'),
(2, 'Job Classification QA', 'Draft', '2025-07-02 15:30:00'),
(3, 'Salary Parsing QA', 'Approved', '2025-06-30 09:45:00');

INSERT INTO RawJobData (JobID, SourceID, RawContent, CollectedAt) VALUES
(1, 1, '{"title":"Software Engineer","location":"Remote"}', '2025-07-01 08:00:00'),
(2, 2, '<html><body>Job: Data Analyst</body></html>', '2025-07-02 14:30:00'),
(3, 3, '{"job":"QA Tester","details":"Full-time role"}', '2025-07-03 17:15:00');

INSERT INTO SavedSearches (UserID, SearchName, Keywords, Location, RemoteOnly, SalaryMin, EmploymentType, FiltersJSON, DateSaved) VALUES
(1, 'Remote Python Roles', 'Python', 'Remote', TRUE, 90000, 'Full-Time', '{"experience":"mid"}', '2025-07-01 09:00:00'),
(2, 'Bay Area SQL Jobs', 'SQL', 'San Francisco, CA', FALSE, 80000, 'Contract', '{"industry":"Finance"}', '2025-07-02 10:45:00'),
(3, 'Junior Roles', '', 'New York, NY', TRUE, 60000, 'Full-Time', '{"title":"junior"}', '2025-07-03 11:30:00');

INSERT INTO SkillCoOccurrences (SkillID1, SkillID2, CoOccurrenceCount) VALUES
(1, 2, 150),   -- Python and SQL
(2, 3, 80),    -- SQL and Excel
(1, 4, 60);  

INSERT INTO SkillSynonyms (CanonicalSkillID, Synonym) VALUES
(1, 'JS'),             -- Maps to JavaScript
(2, 'Structured Query Language'), -- Maps to SQL
(3, 'Py');  

INSERT INTO SyncErrorLogs (ImportID, ErrorMessage, StackTrace, SyncTimestamp) VALUES
(1, 'Connection timeout on endpoint', 'TimeoutException at line 52 in import.py', '2025-07-02 13:05:00'),
(2, 'Missing required field: JobTitle', 'KeyError: "JobTitle"', '2025-07-03 08:12:00'),
(3, 'Authentication failed for SourceID 3', '401 Unauthorized at /token', '2025-07-03 10:20:00');

INSERT INTO SyncSchedules (SourceID, Frequency, LastRun, NextRun, IsActive) VALUES
(1, 'Daily', '2025-07-02 05:00:00', '2025-07-03 05:00:00', TRUE),
(2, 'Weekly', '2025-06-30 06:00:00', '2025-07-07 06:00:00', TRUE),
(3, 'Hourly', '2025-07-03 09:00:00', '2025-07-03 10:00:00', FALSE);

INSERT INTO UserFeedback (ApplicantID, FeedbackType, FeedbackText, SubmittedAt) VALUES
(1, 'Suggestion', 'Add filters for remote-only jobs', '2025-07-01 11:30:00'),
(2, 'Bug', 'Salary filter does not retain values on refresh', '2025-07-02 15:45:00'),
(3, 'Praise', 'Love the dashboard UI!', '2025-07-03 10:10:00');

INSERT INTO UserNotifications (UserID, TemplateID, JobID, SentAt, Status) VALUES
(1, 1, 2, '2025-07-01 09:00:00', 'Sent'),
(2, 2, 3, '2025-07-02 08:30:00', 'Opened'),
(3, 1, 1, '2025-07-03 07:45:00', 'Clicked');