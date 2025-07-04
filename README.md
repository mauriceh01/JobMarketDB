# JobMarketDB

**Job Market Insight Engine** is a full-scale, enterprise-level SQL database system designed to simulate a real-world Job Market Analytics and Applicant Tracking Platform (ATS). It is built to support companies, recruiters, job seekers, analysts, and data engineers through end-to-end job lifecycle tracking, hiring workflows, analytics dashboards, and advanced data intelligence.

## 🧠 Complexity & Innovation:
This is one of the most ambitious SQL projects of its kind, replicating features found in enterprise job boards (like LinkedIn, Indeed, and Greenhouse) and analytics systems (like Tableau HR dashboards or internal recruiter tools). It features:

A normalized yet extensible data model
AI model hooks and feedback tables
Aggregation-ready views and materialized data caches
Data quality assurance through ETL logs and anomaly tracking

## 📌 Features

- 📇 **Employers & Jobs**  
  Companies can post jobs, manage benefits, and engage applicants.

- 👤 **Applicants & Resumes**  
  Users can apply for jobs, track progress, upload documents, and receive recommendations.

- 🧠 **AI & Analytics**  
  Includes job title normalization, skill co-occurrence, and AI-driven job matching.

- 📊 **Dashboards & Trends**  
  Cached salary trends, top skills by region, and saved user dashboards.

- 🔐 **Security & Governance**  
  Full audit trails, consent logging, data anomaly tracking, and compliance tools.

- 🌐 **Internationalization & APIs**  
  Supports multi-language users, API access tokens, and external job data ingestion.

- 💼 **Employer Subscriptions**  
  Pricing plans, job credits, invoicing, promotions, and subscription tracking.

- 💬 **Messaging & Feedback**  
  Live chat, application stages, and feedback from both applicants and employers.

## 🏗️ Database Structure

The database includes over **75+ tables** across functional domains:

| Domain                      | Tables Include |
|----------------------------|----------------|
| Job Postings               | `JobPostings`, `JobSkills`, `JobCategories` |
| Applicants & Applications  | `Applicants`, `Applications`, `ApplicationStages` |
| Skills & Certifications    | `Skills`, `Certifications`, `SkillTrends`, `SkillSynonyms` |
| Salary & Insights          | `SalaryInsights`, `JobTrends`, `CachedSalaryTrends` |
| AI & Recommendation Engine | `NormalizedJobTitles`, `JobRecommendations`, `AIRecommendationFeedback` |
| ETL & Data Governance      | `ETLRunLog`, `DataAuditLog`, `DataAnomalies`, `ModelPerformanceMetrics` |
| Employer Tools             | `Employers`, `EmployerReviews`, `JobPromotions`, `PricingPlans` |
| User Engagement            | `UserEvents`, `SavedSearches`, `UserFeedback`, `Notifications` |
| Compliance & Diversity     | `JobEEOInfo`, `ApplicantDemographics`, `DataConsentLog` |
| API & Import Framework     | `JobImportSources`, `JobImportLogs`, `ApiClients`, `ApiTokens` |
| Archival & QA              | `ArchivedJobPostings`, `DeletedRecords`, `QAJobs` |

## 🧩 Technical Overview
Database: MySQL (fully normalized with foreign keys, indexing, data governance, and performance tuning in mind)
Advanced Features:
AI-powered job matching & feedback loops
NLP-based keyword extraction and skill mapping
Real-time user behavior tracking and job seeker journeys
API integration for job scraping and import logging
Custom dashboards, saved widgets, and performance metrics

## 🚀 Use Cases

- Build a full-featured **job board or career site**
- Support **recruiting teams** with ATS-like workflows and analytics
- Enable **data scientists** to analyze job market trends, skill demand, and salary benchmarks
- Integrate AI for **smart job matching** and user behavior insights
- Power internal HR dashboards for **workforce planning and DEI tracking**

## 💡 Tech Stack (Recommended)

- **Database**: MySQL 8.0+ or compatible
- **ETL / Pipelines**: Python, Airflow, or dbt
- **Frontend (optional)**: Flask, React, or Django
- **Visualization**: Power BI, Tableau, or custom dashboarding

## 📂 Sample Queries (Coming Soon)

Stay tuned for advanced queries, triggers, views, and materialized analytics use cases.

## 📜 License

This schema is open for learning and portfolio use. For commercial use or licensing inquiries, please contact the author.

---

## ✉️ Contact

**Author**: Maurice Hazan  
**Email**: Mauriceh01@hotmail.com  
**Location**: Concord, CA  
