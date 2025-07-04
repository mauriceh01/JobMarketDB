/*
Maurice Hazan
July, 3, 2025
Job Market Insight Engine is a full-scale, enterprise-level SQL database system designed to simulate a real-world Job Market Analytics and Applicant Tracking Platform (ATS). 
It is built to support companies, recruiters, job seekers, analysts, and data engineers through end-to-end job lifecycle tracking, hiring workflows, analytics dashboards, and advanced data intelligence.
This is one of the most ambitious SQL projects of its kind, replicating features found in enterprise job boards (like LinkedIn, Indeed, and Greenhouse) 
and analytics systems (like Tableau HR dashboards or internal recruiter tools). 

It features:
A normalized yet extensible data model AI model hooks and feedback tables Aggregation-ready views and materialized data caches Data quality assurance through ETL logs and anomaly tracking

** Employers & Jobs
Companies can post jobs, manage benefits, and engage applicants.

** Applicants & Resumes
Users can apply for jobs, track progress, upload documents, and receive recommendations.

** AI & Analytics
Includes job title normalization, skill co-occurrence, and AI-driven job matching.

** Dashboards & Trends
Cached salary trends, top skills by region, and saved user dashboards.

** Security & Governance
Full audit trails, consent logging, data anomaly tracking, and compliance tools.

** Internationalization & APIs
Supports multi-language users, API access tokens, and external job data ingestion.

** Employer Subscriptions
Pricing plans, job credits, invoicing, promotions, and subscription tracking.

** Messaging & Feedback
Live chat, application stages, and feedback from both applicants and employers.

*/

CREATE DATABASE JobMarketDB;

USE JobMarketDB;

-- =================================================================================================
-- ******************** Employers table ************************************************************
-- =================================================================================================

CREATE TABLE Employers (
    EmployerID         			INT PRIMARY KEY AUTO_INCREMENT,
    FoundedYear        			INT,
    CompanyName       			VARCHAR(255),
    Industry           			VARCHAR(100),
    Website            			VARCHAR(255),
    Headquarters       			VARCHAR(255),
    CompanySize        			VARCHAR(50),
    GlassdoorRating    			DECIMAL(3,2)
);

-- =================================================================================================
-- ******************** Locations table ************************************************************
-- =================================================================================================

CREATE TABLE Locations (
    LocationID         			INT PRIMARY KEY AUTO_INCREMENT,
    City               			VARCHAR(100),
    State              			VARCHAR(100),
    Country            			VARCHAR(100),
    Latitude           			DECIMAL(10,6),
    Longitude          			DECIMAL(10,6)
);

-- =================================================================================================
-- ******************** Currencies table ***********************************************************
-- =================================================================================================

CREATE TABLE Currencies (
    CurrencyCode      			VARCHAR(10) PRIMARY KEY, -- e.g. 'USD', 'EUR', 'JPY'
    CurrencyName      			VARCHAR(50),
    Symbol            			VARCHAR(10),
    DecimalPrecision  			INT -- number of decimals typically used
);

-- =================================================================================================
-- ******************** JobPostings table **********************************************************
-- =================================================================================================

CREATE TABLE JobPostings (
    JobID              			INT PRIMARY KEY AUTO_INCREMENT,
    EmployerID         			INT,
    LocationID 					INT,
    Currency           			VARCHAR(10),
    JobTitle           			VARCHAR(255),
    JobDescription     			TEXT,
    EmploymentType     			VARCHAR(50), -- e.g., Full-Time, Part-Time, Contract
    Location           			VARCHAR(255),
    RemoteOption       			BOOLEAN,
    SalaryMin          			DECIMAL(10,2),
    SalaryMax          			DECIMAL(10,2),
    PostingDate        			DATETIME,
    ExpirationDate     			DATETIME,
    JobSource             		VARCHAR(100),
    FOREIGN KEY (EmployerID) REFERENCES Employers(EmployerID),
    FOREIGN KEY (LocationID) REFERENCES Locations(LocationID),
    FOREIGN KEY (Currency) REFERENCES Currencies(CurrencyCode)
);

-- =================================================================================================
-- ******************** Skills table ***************************************************************
-- =================================================================================================

CREATE TABLE Skills (
    SkillID            			INT PRIMARY KEY AUTO_INCREMENT,
    SkillName          			VARCHAR(100) UNIQUE
);

-- =================================================================================================
-- ******************** JobSkills table ************************************************************
-- =================================================================================================

CREATE TABLE JobSkills (
    JobID              			INT,
    SkillID            			INT,
    SkillLevel         			VARCHAR(50), -- e.g., Beginner, Intermediate, Expert
    PRIMARY KEY (JobID, SkillID),
    FOREIGN KEY (JobID) REFERENCES JobPostings(JobID),
    FOREIGN KEY (SkillID) REFERENCES Skills(SkillID)
);

-- =================================================================================================
-- ******************** JobCategories table ********************************************************
-- =================================================================================================

-- Job Categories (e.g., Data, Engineering, Marketing)
CREATE TABLE JobCategories (
    CategoryID         			INT PRIMARY KEY AUTO_INCREMENT,
    CategoryName       			VARCHAR(100) UNIQUE
);

-- =================================================================================================
-- ******************** JobCategoryMap table *******************************************************
-- =================================================================================================

-- Linking jobs to categories
CREATE TABLE JobCategoryMap (
    JobID              			INT,
    CategoryID         			INT,
    PRIMARY KEY (JobID, CategoryID),
    FOREIGN KEY (JobID) REFERENCES JobPostings(JobID),
    FOREIGN KEY (CategoryID) REFERENCES JobCategories(CategoryID)
);

-- =================================================================================================
-- ******************** Applicants table ***********************************************************
-- =================================================================================================

-- Applicants (for analytics)
CREATE TABLE Applicants (
    ApplicantID        			INT PRIMARY KEY AUTO_INCREMENT,
    AppName            			VARCHAR(255),
    Location           			VARCHAR(255),
    CurrentTitle       			VARCHAR(100),
    YearsExperience    			DECIMAL(4,1),
    EducationLevel     			VARCHAR(100)
);

-- =================================================================================================
-- ******************** Applications table *********************************************************
-- =================================================================================================

-- Applicant applications

CREATE TABLE Applications (
    ApplicationID      			INT PRIMARY KEY AUTO_INCREMENT,
    JobID              			INT,
    ApplicantID        			INT,
    ApplicationDate    			DATETIME,
    AppStatus          			VARCHAR(50), -- e.g., Submitted, Interviewed, Hired
    FOREIGN KEY (JobID)       REFERENCES JobPostings(JobID),
    FOREIGN KEY (ApplicantID) REFERENCES Applicants(ApplicantID)
);

-- =================================================================================================
-- ******************** SkillTrends table **********************************************************
-- =================================================================================================

-- Skill demand over time
CREATE TABLE SkillTrends (
    SkillID            			INT, 
    DemandCount        			INT,
    SkillMonth              	DATE,
    PRIMARY KEY (SkillID, SkillMonth),
    FOREIGN KEY (SkillID) REFERENCES Skills(SkillID)
);

-- =================================================================================================
-- ******************** SalaryInsights table *******************************************************
-- =================================================================================================

-- Salary insights per role/location
CREATE TABLE SalaryInsights (
	SampleSize         			INT,
    JobTitle           			VARCHAR(255),
    Location           			VARCHAR(255),
    AverageSalary      			DECIMAL(10,2),
    MedianSalary       			DECIMAL(10,2),
    MinSalary          			DECIMAL(10,2),
    MaxSalary          			DECIMAL(10,2),
    DataMonth          			DATE,
    PRIMARY KEY (JobTitle, Location, DataMonth)
);

-- =================================================================================================
-- ******************** DataSources table **********************************************************
-- =================================================================================================

-- Source APIs or Platforms
CREATE TABLE DataSources (
    SourceID           			INT PRIMARY KEY AUTO_INCREMENT,
    SourceName         			VARCHAR(100),
    BaseURL            			VARCHAR(255),
    Description        			TEXT
);

-- =================================================================================================
-- ******************** RawJobData table ***********************************************************
-- =================================================================================================

-- Store raw scraped JSON or HTML
CREATE TABLE RawJobData (
    RawDataID          			INT PRIMARY KEY AUTO_INCREMENT,
    JobID              			INT,
    SourceID           			INT,
    RawContent         			LONGTEXT,
    CollectedAt        			DATETIME,
    FOREIGN KEY (JobID) 	REFERENCES JobPostings(JobID),
    FOREIGN KEY (SourceID) 	REFERENCES DataSources(SourceID)
);

-- =================================================================================================
-- ******************** JobTrends table ************************************************************
-- =================================================================================================

-- Job Demand Trends by Location and Title
CREATE TABLE JobTrends (
    TrendID            			INT PRIMARY KEY AUTO_INCREMENT,
    TotalPostings      			INT,
    JobTitle           			VARCHAR(255),
    Location           			VARCHAR(255),
    JobMonth              		DATE,
    RemotePercentage   			DECIMAL(5,2),
    FOREIGN KEY (JobTitle, Location) REFERENCES SalaryInsights(JobTitle, Location)
);

-- =================================================================================================
-- ******************** SkillCoOccurrences table ***************************************************
-- =================================================================================================

-- Skill Co-occurrence (Skills that appear together in job listings)
CREATE TABLE SkillCoOccurrences (
    PairID              		INT PRIMARY KEY AUTO_INCREMENT,
    SkillID1            		INT,
    SkillID2            		INT,
    CoOccurrenceCount   		INT,
    FOREIGN KEY (SkillID1) REFERENCES Skills(SkillID),
    FOREIGN KEY (SkillID2) REFERENCES Skills(SkillID),
    CONSTRAINT chk_SkillsDifferent CHECK (SkillID1 != SkillID2)
);

-- =================================================================================================
-- ******************** EmployerReviews table ******************************************************
-- =================================================================================================

-- Employer Reviews (for qualitative analysis)
CREATE TABLE EmployerReviews (
    ReviewID           			INT PRIMARY KEY AUTO_INCREMENT,
    EmployerID         			INT,
    ReviewTitle        			VARCHAR(255),
    ReviewText         			TEXT,
    Rating             			DECIMAL(2,1),
    ReviewDate         			DATE,
    ReviewerTitle      			VARCHAR(100),
    Location           			VARCHAR(255),
    FOREIGN KEY (EmployerID) REFERENCES Employers(EmployerID)
);

-- =================================================================================================
-- ******************** Certifications table *******************************************************
-- =================================================================================================

-- Certifications Mentioned in Job Descriptions
CREATE TABLE Certifications (
    CertificationID    			INT PRIMARY KEY AUTO_INCREMENT,
    CertificationName  			VARCHAR(255),
    IssuingAuthority   			VARCHAR(255),
    Description        			TEXT
);

-- =================================================================================================
-- ******************** JobCertifications table ****************************************************
-- =================================================================================================

CREATE TABLE JobCertifications (
    JobID              			INT,
    CertificationID    			INT,
    RequiredOrPreferred 		VARCHAR(50),
    PRIMARY KEY (JobID, CertificationID),
    FOREIGN KEY (JobID) REFERENCES JobPostings(JobID),
    FOREIGN KEY (CertificationID) REFERENCES Certifications(CertificationID)
);

-- =================================================================================================
-- ******************** EducationRequirements table ************************************************
-- =================================================================================================

-- Education Requirements by Job
CREATE TABLE EducationRequirements (
    JobID              			INT,
    EducationLevel     			VARCHAR(100), -- e.g. "Bachelor's Degree", "High School Diploma"
    IsRequired         			BOOLEAN,
    PRIMARY KEY (JobID, EducationLevel),
    FOREIGN KEY (JobID) REFERENCES JobPostings(JobID)
);

-- =================================================================================================
-- ******************** JobBenefits table **********************************************************
-- =================================================================================================

-- Job Benefit Packages
CREATE TABLE JobBenefits (
    JobID              			INT,
    Benefit            			VARCHAR(100), -- e.g. "Health Insurance", "401(k)", "Remote Work"
    PRIMARY KEY (JobID, Benefit),
    FOREIGN KEY (JobID) REFERENCES JobPostings(JobID)
);

-- =================================================================================================
-- ******************** SavedJobs table ************************************************************
-- =================================================================================================

-- User Interaction & Insights
-- Saved Jobs or Bookmarked by Users

CREATE TABLE SavedJobs (
    SaveID             			INT PRIMARY KEY AUTO_INCREMENT,
    ApplicantID        			INT,
    JobID              			INT,
    SavedDate          			DATETIME,
    FOREIGN KEY (ApplicantID) 	REFERENCES Applicants(ApplicantID),
    FOREIGN KEY (JobID) 		REFERENCES JobPostings(JobID)
);

-- =================================================================================================
-- ******************** UserFeedback table *********************************************************
-- =================================================================================================

-- User Feedback for Dashboard Usability (optional if you’re building UI)

CREATE TABLE UserFeedback (
    FeedbackID         			INT PRIMARY KEY AUTO_INCREMENT,
    ApplicantID        			INT,
    FeedbackType       			VARCHAR(50), -- e.g., "Bug", "Suggestion"
    FeedbackText       			TEXT,
    SubmittedAt        			DATETIME,
    FOREIGN KEY (ApplicantID) REFERENCES Applicants(ApplicantID)
);

-- =================================================================================================
-- ******************** Languages table ************************************************************
-- =================================================================================================

--  Internationalization (i18n) & Localization

CREATE TABLE Languages (
    LanguageCode       			VARCHAR(10) PRIMARY KEY, -- e.g., 'en', 'es', 'fr'
    LanguageName       			VARCHAR(100)
);

-- =================================================================================================
-- ******************** Users table ************************************************************
-- =================================================================================================

-- User Management & Roles (Admin, Recruiter, Analyst)


CREATE TABLE Users (
    UserID             			INT PRIMARY KEY AUTO_INCREMENT,
    PreferredLanguage 			VARCHAR(10),
    Username           			VARCHAR(100) UNIQUE,
    PasswordHash       			VARCHAR(255),
    Email              			VARCHAR(255) UNIQUE,
    FullName           			VARCHAR(255),
    Role               			VARCHAR(50), -- Admin, Analyst, Recruiter, Viewer
    CreatedAt          			DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (PreferredLanguage) REFERENCES Languages(LanguageCode)
);

-- =================================================================================================
-- ******************** LoginAuditLog table ********************************************************
-- =================================================================================================

CREATE TABLE LoginAuditLog (
    AuditID            			INT PRIMARY KEY AUTO_INCREMENT,
    UserID             			INT,
    LoginTimestamp     			DATETIME,
    IPAddress          			VARCHAR(45),
    DeviceInfo         			VARCHAR(255),
    Success            			BOOLEAN,
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);

-- =================================================================================================
-- ******************** ETLRunLog table ************************************************************
-- =================================================================================================
--  ETL Logs & Data Quality Control

CREATE TABLE ETLRunLog (
    RunID              			INT PRIMARY KEY AUTO_INCREMENT,
    SourceID           			INT,
    RunDate            			DATETIME,
    RecordsExtracted   			INT,
    RecordsInserted    			INT,
    RecordsFailed      			INT,
    RunStatus          			VARCHAR(50), -- Success, Failed, Partial
    Notes              			TEXT,
    FOREIGN KEY (SourceID) REFERENCES DataSources(SourceID)
);

-- =================================================================================================
-- ******************** DataAnomalies table ********************************************************
-- =================================================================================================


CREATE TABLE DataAnomalies (
    AnomalyID          			INT PRIMARY KEY AUTO_INCREMENT,
    TableName          			VARCHAR(100),
    RecordID           			INT,
    AnomalyType        			VARCHAR(100), -- e.g. NULLs, Outlier Salary, Invalid Skill Mapping
    DetectedAt        			DATETIME,
    Notes              			TEXT
);

-- =================================================================================================
-- ******************** NormalizedJobTitles table **************************************************
-- =================================================================================================

-- AI-Powered Insight Tables
-- AI-generated job title standardization

CREATE TABLE NormalizedJobTitles (
    NormalizedID       			INT PRIMARY KEY AUTO_INCREMENT,
    RawTitle           			VARCHAR(255),
    StandardTitle      			VARCHAR(255),
    ConfidenceScore    			DECIMAL(5,2), -- from ML model
    CreatedAt          			DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- =================================================================================================
-- ******************** JobRecommendations table ***************************************************
-- =================================================================================================

-- AI recommendations for related jobs

CREATE TABLE JobRecommendations (
    SourceJobID        			INT,
    RecommendedJobID   			INT,
    Score              			DECIMAL(5,2), -- similarity score
    Reason             			VARCHAR(255),
    CreatedAt 					DATETIME DEFAULT CURRENT_TIMESTAMP,
    AlgorithmVersion 			VARCHAR(50),
    PRIMARY KEY (SourceJobID, RecommendedJobID),
    FOREIGN KEY (SourceJobID) REFERENCES JobPostings(JobID) ON DELETE CASCADE,
    FOREIGN KEY (RecommendedJobID) REFERENCES JobPostings(JobID) ON DELETE CASCADE
);

-- =================================================================================================
-- ******************** TopSkillsByRegion table ****************************************************
-- =================================================================================================

-- Materialized Views & Performance Tables for Dashboard
-- These are populated via scheduled queries or triggers and are used for fast-loading dashboards.
-- Cached Top Skills by Region

CREATE TABLE TopSkillsByRegion (
    Region             			VARCHAR(100),
    SkillID            			INT,
    JobID						INT,
    DemandCount        			INT,
    TopRank            			INT,
    LastUpdated        			DATETIME,
    PRIMARY KEY (Region, SkillID),
    FOREIGN KEY (SkillID) REFERENCES Skills(SkillID),
    FOREIGN KEY (JobID) REFERENCES JobPostings(JobID) ON DELETE CASCADE
);

-- =================================================================================================
-- ******************** CachedSalaryTrends table ***************************************************
-- =================================================================================================

-- Cached Average Salary Trends

CREATE TABLE CachedSalaryTrends (
	JobID						INT,
    JobTitle           			VARCHAR(255),
    Region             			VARCHAR(100),
    CachedMonth              	DATE,
    AverageSalary      			DECIMAL(10,2),
    SalaryChangePercent 		DECIMAL (4, 1),
    JobCount           			INT,
    LastUpdated        			DATETIME,
    PRIMARY KEY (JobTitle, Region, CachedMonth),
    FOREIGN KEY (JobID) REFERENCES JobPostings(JobID) ON DELETE CASCADE
);

-- =================================================================================================
-- ******************** JobTags table ************************************************************
-- =================================================================================================

 
-- Tagging, Notes & Annotations
-- Analysts tagging jobs for reports or user research

CREATE TABLE JobTags (
    TagID              			INT PRIMARY KEY AUTO_INCREMENT,
    TagName            			VARCHAR(100),
    Description        			TEXT
);

-- =================================================================================================
-- ******************** JobTagMap table ************************************************************
-- =================================================================================================

CREATE TABLE JobTagMap (
    JobID              			INT,
    TagID              			INT,
    TaggedBy           			INT,
    TagDate            			DATETIME,
    PRIMARY KEY (JobID, TagID),
    FOREIGN KEY (JobID) REFERENCES JobPostings(JobID),
    FOREIGN KEY (TagID) REFERENCES JobTags(TagID),
    FOREIGN KEY (TaggedBy) REFERENCES Users(UserID)
);

-- =================================================================================================
-- ******************** JobAnnotations table *******************************************************
-- =================================================================================================

-- Analyst notes for qualitative insights

CREATE TABLE JobAnnotations (
    AnnotationID       			INT PRIMARY KEY AUTO_INCREMENT,
    JobID              			INT,
    AnnotatedBy       			INT,
    AnnotationText     			TEXT,
    AnnotatedAt        			DATETIME,
    FOREIGN KEY (JobID) REFERENCES JobPostings(JobID) ON DELETE CASCADE,
	FOREIGN KEY (AnnotatedBy) REFERENCES Users(UserID)
);    

-- =================================================================================================
-- ******************** UserEvents table ***********************************************************
-- =================================================================================================

-- User Interaction & Event Tracking
-- Tracks every major action on the platform (views, clicks, filters used, etc.)

CREATE TABLE UserEvents (
    EventID            			INT PRIMARY KEY AUTO_INCREMENT,
    UserID             			INT,
    JobID						INT,
    EventType          			VARCHAR(100), -- e.g., "ViewedJob", "Applied", "SavedSearch", "FilteredBySkill"
    EventDescription   			TEXT,
    UserTimestamp          		DATETIME DEFAULT CURRENT_TIMESTAMP,
    PageURL            			VARCHAR(255),
    FOREIGN KEY (UserID) REFERENCES Users(UserID),
    FOREIGN KEY (JobID) REFERENCES JobPostings(JobID) ON DELETE CASCADE
);

-- =================================================================================================
-- ******************** UserJourney table **********************************************************
-- =================================================================================================

--  Job Seeker Journey Tracking
-- Track steps in a user’s job search behavior

CREATE TABLE UserJourney (
    JourneyID          			INT PRIMARY KEY AUTO_INCREMENT,
    ApplicantID        			INT,
    Stage              			VARCHAR(100), -- e.g., "Search", "View", "Save", "Apply"
    JobID              			INT,
    Timestamp          			DATETIME,
    Notes              			TEXT,
    FOREIGN KEY (ApplicantID) REFERENCES Applicants(ApplicantID),
    FOREIGN KEY (JobID) REFERENCES JobPostings(JobID) ON DELETE CASCADE
);

-- =================================================================================================
-- ******************** NotificationTemplates table ************************************************
-- =================================================================================================

-- Notification & Alert System
-- Notification types and templates

CREATE TABLE NotificationTemplates (
    TemplateID         			INT PRIMARY KEY AUTO_INCREMENT,
    NotificationType   			VARCHAR(100), -- "NewJobMatch", "SalaryAlert"
    SubjectTemplate    			VARCHAR(255),
    BodyTemplate       			TEXT
);

-- =================================================================================================
-- ******************** UserNotifications table ****************************************************
-- =================================================================================================

-- Individual user notifications

CREATE TABLE UserNotifications (
    NotificationID     			INT PRIMARY KEY AUTO_INCREMENT,
    UserID             			INT,
    TemplateID         			INT,    
    JobID              			INT,
    SentAt             			DATETIME,
    Status             			VARCHAR(50), -- "Sent", "Opened", "Clicked"
    FOREIGN KEY (UserID) REFERENCES Users(UserID),
    FOREIGN KEY (TemplateID) REFERENCES NotificationTemplates(TemplateID),
    FOREIGN KEY (JobID) REFERENCES JobPostings(JobID)
);

-- =================================================================================================
-- ******************** SavedSearches table ********************************************************
-- =================================================================================================

--  Saved Searches & Custom Filters
-- Job seekers or analysts saving specific search filters


CREATE TABLE SavedSearches (
    SearchID           			INT PRIMARY KEY AUTO_INCREMENT,
    UserID             			INT,
    SearchName         			VARCHAR(100),
    Keywords           			TEXT,
    Location           			VARCHAR(255),
    RemoteOnly         			BOOLEAN,
    SalaryMin          			DECIMAL(10,2),
    EmploymentType     			VARCHAR(50),
    FiltersJSON					JSON,
    DateSaved          			DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);

-- =================================================================================================
-- ******************** JobKeywords table **********************************************************
-- =================================================================================================

--  NLP & Keyword Extraction (Advanced Search Intelligence)
-- Keywords extracted from job descriptions using NLP

CREATE TABLE JobKeywords (
    KeywordID          			INT PRIMARY KEY AUTO_INCREMENT,
    JobID              			INT,
    Keyword            			VARCHAR(100),
    Frequency          			INT,
    IsTechnical        			BOOLEAN,
    FOREIGN KEY (JobID) REFERENCES JobPostings(JobID) ON DELETE CASCADE
);

-- =================================================================================================
-- ******************** JobAlerts table ************************************************************
-- =================================================================================================

CREATE TABLE JobAlerts (
    AlertID             		INT PRIMARY KEY AUTO_INCREMENT,
    ApplicantID        			INT,
    AlertName           		VARCHAR(100),
    Keywords            		VARCHAR(255),
    Location            		VARCHAR(100),
    MinSalary           		DECIMAL(10,2),
    EmploymentType      		VARCHAR(50), -- Full-Time, Part-Time, Contract
    CreatedAt           		DATETIME DEFAULT NOW(),
    Frequency           		VARCHAR(50), -- Daily, Weekly, Instant
    IsActive            		BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (ApplicantID) REFERENCES Applicants(ApplicantID) ON DELETE CASCADE
);

-- =================================================================================================
-- ******************** GlobalKeywordTrends table **************************************************
-- =================================================================================================

-- Keyword popularity across all listings

CREATE TABLE GlobalKeywordTrends (
    Keyword            			VARCHAR(100),
    GlobalMonth              	DATE,
    Frequency         			INT,
    GlobalRank         			INT,
    PRIMARY KEY (Keyword, GlobalMonth)
);

-- =================================================================================================
-- ******************** EmployerCompetitors table **************************************************
-- =================================================================================================

--  Regional Trends & Competitor Tracking
-- Competing employers in a given region

CREATE TABLE EmployerCompetitors (
    EmployerID         			INT,
    CompetitorID       			INT,
    Region             			VARCHAR(100),
    PRIMARY KEY (EmployerID, CompetitorID, Region),
    FOREIGN KEY (EmployerID) REFERENCES Employers(EmployerID),
    FOREIGN KEY (CompetitorID) REFERENCES Employers(EmployerID)
);

-- =================================================================================================
-- ******************** EmployerMonthlyPostings table **********************************************
-- =================================================================================================

-- Track how many postings per employer in a region per month

CREATE TABLE EmployerMonthlyPostings (
    EmployerID         			INT,
    Region             			VARCHAR(100),
    EmployerMonth              	DATE,
    TotalPostings      			INT,
    PRIMARY KEY (EmployerID, Region, EmployerMonth),
    FOREIGN KEY (EmployerID) REFERENCES Employers(EmployerID)
);

-- =================================================================================================
-- ******************** JobImportSources table *****************************************************
-- =================================================================================================

-- External API & Job Scraping Integration
-- API endpoints or scrapers configured for job ingestion

CREATE TABLE JobImportSources (
    SourceID           			INT PRIMARY KEY AUTO_INCREMENT,
    SourceName         			VARCHAR(100),
    SourceType         			VARCHAR(50), -- "API", "Scraper", "RSS"
    EndpointURL        			VARCHAR(255),
    AuthMethod         			VARCHAR(50), -- e.g., "OAuth2", "API Key", "None"
    Description        			TEXT
);

-- =================================================================================================
-- ******************** JobImportLogs table ********************************************************
-- =================================================================================================

-- Log each import/scrape job

CREATE TABLE JobImportLogs (
    ImportID           			INT PRIMARY KEY AUTO_INCREMENT,
    SourceID           			INT,
    StartTime          			DATETIME,
    EndTime            			DATETIME,
    JobsFound          			INT,
    JobsInserted       			INT,
    JobImportErrors    			INT,
    JobImportStatus             VARCHAR(50),
    Notes              			TEXT,
    FOREIGN KEY (SourceID) REFERENCES JobImportSources(SourceID)
);

-- ================================================================================================
-- ******************** SyncSchedules table *******************************************************
-- =================================================================================================

--  Data Refresh & Sync Control
-- Schedule table for syncing data sources

CREATE TABLE SyncSchedules (
    ScheduleID         			INT PRIMARY KEY AUTO_INCREMENT,
    SourceID           			INT,
    Frequency          			VARCHAR(50), -- "Daily", "Hourly", "Weekly"
    LastRun            			DATETIME,
    NextRun            			DATETIME,
    IsActive           			BOOLEAN,
    FOREIGN KEY (SourceID) 		REFERENCES JobImportSources(SourceID)
);

-- =================================================================================================
-- ******************** SyncErrorLogs table ********************************************************
-- =================================================================================================

-- Error log for failed data syncs

CREATE TABLE SyncErrorLogs (
    ErrorID            			INT PRIMARY KEY AUTO_INCREMENT,
    ImportID           			INT,
    ErrorMessage      			TEXT,
    StackTrace         			TEXT,
    SyncTimestamp          		DATETIME,
    FOREIGN KEY (ImportID) REFERENCES JobImportLogs(ImportID)
);

-- =================================================================================================
-- ******************** JobEEOInfo table ***********************************************************
-- =================================================================================================

-- Compliance, EEO, and Diversity Tracking
-- Optional EEO & DEI fields captured from employers or inferred

CREATE TABLE JobEEOInfo (
    JobID              			INT PRIMARY KEY,
    IsEEOCompliant     			BOOLEAN,
    DiversityStatement 			TEXT,
    MinorityRecruiting 			BOOLEAN,
    FOREIGN KEY (JobID) REFERENCES JobPostings(JobID)
);

-- =================================================================================================
-- ******************** ApplicantDemographics table ************************************************
-- =================================================================================================

-- Anonymous reporting of demographic trends (aggregated)

CREATE TABLE ApplicantDemographics (
    ApplicantID        			INT,
    Gender             			VARCHAR(50),
    Ethnicity          			VARCHAR(100),
    DisabilityStatus   			VARCHAR(100),
    VeteranStatus      			VARCHAR(100),
    Disclosed          			BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (ApplicantID) REFERENCES Applicants(ApplicantID)
);

-- =================================================================================================
-- ******************** DataAuditLog table *********************************************************
-- =================================================================================================

--  Audit Trails & Data Governance
-- Tracks changes to critical data (jobs, salaries, users)

CREATE TABLE DataAuditLog (
    AuditID            			INT PRIMARY KEY AUTO_INCREMENT,
    TableName          			VARCHAR(100),
    RecordID           			INT,
    ChangedBy          			INT,
    ChangeType         			VARCHAR(50), -- "INSERT", "UPDATE", "DELETE"
    ChangeTimestamp    			DATETIME,
    OldValue           			TEXT,
    NewValue           			TEXT,
    FOREIGN KEY (ChangedBy) REFERENCES Users(UserID)
);

-- =================================================================================================
-- ******************** DataConsentLog table *******************************************************
-- =================================================================================================

-- Records of consent for data collection (GDPR, CCPA, etc.)

CREATE TABLE DataConsentLog (
    ConsentID          			INT PRIMARY KEY AUTO_INCREMENT,
    UserID             			INT,
    ConsentType        			VARCHAR(100),
    ConsentGivenAt     			DATETIME,
    ConsentMethod      			VARCHAR(50), -- "Checkbox", "Digital Signature"
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);

-- =================================================================================================
-- ******************** AIRecommendationFeedback table *********************************************
-- =================================================================================================

-- AI Model Feedback Loop (Smart Matching & Tuning)
-- Tracks whether AI job recommendations were relevant or helpful

CREATE TABLE AIRecommendationFeedback (
    FeedbackID         			INT PRIMARY KEY AUTO_INCREMENT,
    UserID             			INT,
    JobID              			INT,
    RecommendationType 			VARCHAR(100), -- "SimilarJob", "SkillMatch"
    WasHelpful         			BOOLEAN,
    Comments           			TEXT,
    Timestamp          			DATETIME,
    FOREIGN KEY (UserID) REFERENCES Users(UserID),
    FOREIGN KEY (JobID) REFERENCES JobPostings(JobID)
);

-- =================================================================================================
-- ******************** ModelPerformanceMetrics table **********************************************
-- =================================================================================================

-- Stores model accuracy over time (manual or automated)

CREATE TABLE ModelPerformanceMetrics (
    MetricID           			INT PRIMARY KEY AUTO_INCREMENT,
    ModelName          			VARCHAR(100),
    Version            			VARCHAR(50),
    EvaluationDate     			DATE,
    ModelPrecision     			DECIMAL(5,4),
    Recall             			DECIMAL(5,4),
    F1Score            			DECIMAL(5,4),
    Notes              			TEXT
);

-- =================================================================================================
-- ******************** PricingPlans table *********************************************************
-- =================================================================================================

-- Pricing Plans & Employer Subscriptions
-- Define pricing tiers for employers (monthly plans, per-post, etc.)

CREATE TABLE PricingPlans (
    PlanID             			INT PRIMARY KEY AUTO_INCREMENT,
    PlanName           			VARCHAR(100),
    Description        			TEXT,
    PriceUSD           			DECIMAL(10,2),
    MaxJobPostings     			INT,
    DurationDays       			INT,
    IncludesPromotions 			BOOLEAN
);

-- =================================================================================================
-- ******************** EmployerSubscriptions table ************************************************
-- =================================================================================================

-- Employers who subscribed to a pricing plan

CREATE TABLE EmployerSubscriptions (
    SubscriptionID     			INT PRIMARY KEY AUTO_INCREMENT,
    EmployerID        			INT,
    PlanID             			INT,
    StartDate          			DATE,
    EndDate            			DATE,
    PaymentMethod     			VARCHAR(50),
    PaymentStatus      			VARCHAR(50), -- e.g., Active, Failed, Cancelled
    FOREIGN KEY (EmployerID) REFERENCES Employers(EmployerID),
    FOREIGN KEY (PlanID) REFERENCES PricingPlans(PlanID)
);

-- =================================================================================================
-- ******************** JobCredits table ***********************************************************
-- =================================================================================================

-- Job Credits & Limits
-- Track job posting credits (e.g. "post up to 10 jobs/month")

CREATE TABLE JobCredits (
    CreditID           			INT PRIMARY KEY AUTO_INCREMENT,
    EmployerID         			INT,
    CreditsAvailable   			INT,
    CreditsUsed        			INT DEFAULT 0,
    LastUpdated        			DATETIME,
    FOREIGN KEY (EmployerID)REFERENCES Employers(EmployerID)
);

-- =================================================================================================
-- ******************** JobPromotions table ********************************************************
-- =================================================================================================

-- Campaigns & Promotions
-- Promotional campaigns (e.g. featured jobs, sponsored listings)

CREATE TABLE JobPromotions (
    PromotionID        			INT PRIMARY KEY AUTO_INCREMENT,
    JobID              			INT,
    PromotionType      			VARCHAR(100), -- "Featured", "Homepage", "Email Blast", "Highlighted", "Sponsored"
    StartDate          			DATE,
    EndDate           			DATE,
    CostUSD            			DECIMAL(10,2),
    Impressions        			INT DEFAULT 0,
    Clicks             			INT DEFAULT 0,
    FOREIGN KEY (JobID) REFERENCES JobPostings(JobID) ON DELETE CASCADE
);

-- =================================================================================================
-- ******************** ChatThreads table **********************************************************
-- =================================================================================================

-- Live Chat / Messaging System
-- Chat threads between job seekers and employers

CREATE TABLE ChatThreads (
    ThreadID           			INT PRIMARY KEY AUTO_INCREMENT,
    ApplicantID        			INT,
    EmployerID         			INT,
    JobID              			INT,
    CreatedAt          			DATETIME,
    FOREIGN KEY (ApplicantID) REFERENCES Applicants(ApplicantID),
    FOREIGN KEY (EmployerID) REFERENCES Employers(EmployerID),
    FOREIGN KEY (JobID) REFERENCES JobPostings(JobID)
);

-- =================================================================================================
-- ******************** ChatMessages table **********************************************************
-- =================================================================================================


-- Individual messages within a thread

CREATE TABLE ChatMessages (	
    MessageID          			INT PRIMARY KEY AUTO_INCREMENT,
    ThreadID           			INT,
    SenderID           			INT,
    MessageText        			TEXT,
    SenderType         			VARCHAR(50), -- "Employer" or "Applicant"
    SentAt             			DATETIME,
    FOREIGN KEY (ThreadID)  REFERENCES ChatThreads(ThreadID)
);

-- =================================================================================================
-- ******************** ApplicationStages table ****************************************************
-- =================================================================================================

-- Application Tracking System (ATS-style) Stages
-- Define stages in the applicant funnel

CREATE TABLE ApplicationStages (
    StageID            			INT PRIMARY KEY AUTO_INCREMENT,    
    StageOrder         			INT,
    StageName          			VARCHAR(100) -- e.g. "Submitted", "Phone Screen", "Interview", "Offer"
);

-- =================================================================================================
-- ******************** ApplicationProgress table **************************************************
-- =================================================================================================

-- Applicant’s progress through the pipeline for a job

CREATE TABLE ApplicationProgress (
    ApplicationID      			INT,
    StageID            			INT,
    UpdatedAt          			DATETIME,
    Notes              			TEXT,
    PRIMARY KEY (ApplicationID, StageID),
    FOREIGN KEY (ApplicationID) REFERENCES Applications(ApplicationID),
    FOREIGN KEY (StageID) REFERENCES ApplicationStages(StageID)
);

-- =================================================================================================
-- ******************** EmployerInvoices table *****************************************************
-- =================================================================================================

-- Billing History & Invoices
-- Store invoice and payment info

CREATE TABLE EmployerInvoices (
    InvoiceID          			INT PRIMARY KEY AUTO_INCREMENT,
    EmployerID         			INT,
    InvoiceDate        			DATE,
    AmountUSD          			DECIMAL(10,2),
    Description        			TEXT,
    Paid               			BOOLEAN,
    PaymentDate        			DATE,
    PaymentMethod      			VARCHAR(50),
    FOREIGN KEY (EmployerID) REFERENCES Employers(EmployerID)
);

-- =================================================================================================
-- ******************** ApiClients table ************************************************************
-- =================================================================================================

-- API Access & Tokens

CREATE TABLE ApiClients (
    ClientID           			INT PRIMARY KEY AUTO_INCREMENT,
    ClientName         			VARCHAR(100),
    ContactEmail       			VARCHAR(255),
    IsActive           			BOOLEAN,
    CreatedAt          			DATETIME
);

-- =================================================================================================
-- ******************** ApiTokens table ************************************************************
-- =================================================================================================

CREATE TABLE ApiTokens (
    TokenID            			INT PRIMARY KEY AUTO_INCREMENT,
    ClientID           			INT,
    Token              			VARCHAR(255),
    Expiration         			DATETIME,
    Scope              			VARCHAR(255), -- "read_jobs", "post_jobs"
    IsRevoked          			BOOLEAN DEFAULT FALSE,
    CreatedAt          			DATETIME,
    FOREIGN KEY (ClientID)  	REFERENCES ApiClients(ClientID)
);

-- =================================================================================================
-- ******************** ArchivedJobPostings table **************************************************
-- =================================================================================================
-- 🧹 Soft Deletes / Archiving / Retention

CREATE TABLE ArchivedJobPostings (
    ArchiveID          			INT PRIMARY KEY AUTO_INCREMENT,
    OriginalJobID      			INT,
    EmployerID         			INT,
    JobTitle           			VARCHAR(255),
    ArchivedAt         			DATETIME,
    Reason             			VARCHAR(255)
);

-- =================================================================================================
-- ******************** DeletedRecords table *******************************************************
-- =================================================================================================

CREATE TABLE DeletedRecords (
    DeleteID           			INT PRIMARY KEY AUTO_INCREMENT,
    RecordID           			INT,
    DeletedBy          			INT, 
    TableName          			VARCHAR(100),
    DeletedAt          			DATETIME,
    Reason             			TEXT,
    FOREIGN KEY (DeletedBy) 	REFERENCES Users(UserID)
);

-- =================================================================================================
-- ******************** QAJobs table ***************************************************************
-- =================================================================================================

--  QA/Test Environments

CREATE TABLE QAJobs (
    QAJobID            			INT PRIMARY KEY AUTO_INCREMENT,
    CreatedBy          			INT,
    Title              			VARCHAR(255),
    QAStatus           			VARCHAR(50), -- Draft, Pending, Approved
    CreatedAt          			DATETIME,
    FOREIGN KEY (CreatedBy) 	REFERENCES Users(UserID)
);

-- =================================================================================================
-- ******************** JobSearchIndex table *******************************************************
-- =================================================================================================

-- Search Indexing & Performance Optimization
-- Preprocessed keyword index for fast search

CREATE TABLE JobSearchIndex (
    JobID              			INT PRIMARY KEY,
    IndexedTitle        		TEXT, -- concatenated title, skills, description
    IndexedDescription			VARCHAR(200),
    IndexedSkills				VARCHAR(200),
    LastIndexed        			DATETIME,
    FOREIGN KEY (JobID) 		REFERENCES JobPostings(JobID) ON DELETE CASCADE
);


-- =================================================================================================
-- ******************** SkillSynonyms table ********************************************************
-- =================================================================================================

-- Skill synonym mapping (e.g., “JS” = “JavaScript”)

CREATE TABLE SkillSynonyms (
    SynonymID          			INT PRIMARY KEY AUTO_INCREMENT,
    CanonicalSkillID   			INT,
    Synonym            			VARCHAR(100),
    FOREIGN KEY (CanonicalSkillID) REFERENCES Skills(SkillID)
);

-- =================================================================================================
-- ******************** SavedDashboards table ******************************************************
-- =================================================================================================

--  Saved Dashboards & User Widgets

CREATE TABLE SavedDashboards (
    DashboardID        			INT PRIMARY KEY AUTO_INCREMENT,
    UserID             			INT,
    DashboardName      			VARCHAR(100),
    ConfigJSON         			JSON,
    CreatedAt          			DATETIME,
    FOREIGN KEY (UserID) 		REFERENCES Users(UserID)
);

-- =================================================================================================
-- ******************** DashboardWidgets table *****************************************************
-- =================================================================================================

CREATE TABLE DashboardWidgets (
    WidgetID           			INT PRIMARY KEY AUTO_INCREMENT,
    DashboardID        			INT,
    WidgetType         			VARCHAR(100),
    PositionOrder      			INT,
    ConfigJSON         			JSON,
    FOREIGN KEY (DashboardID) REFERENCES SavedDashboards(DashboardID)
);

-- =================================================================================================
-- ******************** CompanyReviews table *******************************************************
-- =================================================================================================

CREATE TABLE CompanyReviews (
    ReviewID 					INT PRIMARY KEY AUTO_INCREMENT,
    EmployerID 					INT NOT NULL,
    ReviewerName 				VARCHAR(100),
    ReviewDate 					DATE,
    Rating 						DECIMAL(2,1) CHECK (Rating >= 0 AND Rating <= 5),
    Pros 						TEXT,
    Cons						TEXT,
    ReviewTitle 				VARCHAR(255),
    ReviewText 					TEXT,
    FOREIGN KEY (EmployerID) REFERENCES Employers(EmployerID) ON DELETE CASCADE
);

-- ==================================================================================================
-- ******************** EmailSubscriptions table ****************************************************
-- ==================================================================================================

CREATE TABLE EmailSubscriptions (
    SubscriptionID 				INT PRIMARY KEY AUTO_INCREMENT,
    UserID 						INT NOT NULL,
    SubscriptionType 			VARCHAR(100),      -- e.g. "Job Alerts", "Newsletter", "Promotions"
    Email 						VARCHAR(255) NOT NULL,
    SubscribedDate 				DATETIME DEFAULT CURRENT_TIMESTAMP,
    IsActive 					BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (UserID) REFERENCES Users(UserID) ON DELETE CASCADE
);

-- =================================================================================================
-- ******************** ApplicantDocuments table ***************************************************
-- =================================================================================================

CREATE TABLE ApplicantDocuments (
    DocumentID 					INT PRIMARY KEY AUTO_INCREMENT,
    ApplicantID 				INT NOT NULL,
    DocumentType 				VARCHAR(100),          -- e.g. "Resume", "Cover Letter", "Certificate"
    DocumentName 				VARCHAR(255),
    DocumentPath 				VARCHAR(500),          -- file path or URL to stored document
    UploadDate 					DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (ApplicantID) REFERENCES Applicants(ApplicantID) ON DELETE CASCADE
);

-- =================================================================================================
-- ******************** InterviewFeedback table ****************************************************
-- =================================================================================================

CREATE TABLE InterviewFeedback (
    FeedbackID 					INT PRIMARY KEY AUTO_INCREMENT,
    ApplicationID 				INT NOT NULL,
    InterviewerName 			VARCHAR(100),
    InterviewDate 				DATE,
    FeedbackText 				TEXT,
    Rating 						DECIMAL(2,1) CHECK (Rating >= 0 AND Rating <= 5),
    CreatedAt 					DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (ApplicationID) REFERENCES Applications(ApplicationID) ON DELETE CASCADE
);
