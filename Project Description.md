# Data-Jobs-Analysis

## Introduction 🌟

In today's dynamic job market, understanding the landscape of data-related roles is crucial for both job seekers and employers. This Data Analytics project delves into comprehensive data on job postings, aiming to unveil the intricacies of the data job market. By leveraging a robust dataset, we analyze various aspects such as top-paying jobs, in-demand skills, job trends across locations and time, and the most optimal skills for different data professions. This project serves as a valuable resource for anyone looking to navigate the competitive world of data jobs, offering insights that can guide career decisions and strategic hiring practices.

Want to look at the SQL queries🤔 Here you go : [SQL Queries](Queries)

## Objective 🎯

The primary objective of this project is to provide actionable insights into the data job market through detailed analysis of job postings. Specifically, we aim to:

1. **Identify Top Paying Jobs 💰**: Determine which companies offer the highest salaries for data-related roles.
2. **Highlight In-Demand Skills 🛠️**: Analyze which skills are most sought after in the industry and how they correlate with job categories like Data Analyst, Data Engineer, and Data Scientist.
3. **Track Job Trends 📈**: Explore how job availability and requirements have evolved over time and across different locations.
4. **Optimize Skill Development 🚀**: Identify the most optimal skills for job seekers to develop in order to enhance their employability and earning potential.

By achieving these objectives, our project aims to empower individuals and organizations with the knowledge needed to make informed decisions in the ever-evolving field of data analytics.

## Background:
This data has been collected from this source. [Data Source](https://www.lukebarousse.com/sql)📊

I've designed and implemented a relational database to store and analyze job posting data. The database is structured to provide insights into job trends, required skills, and salary information.
The project uses four primary tables to organize and analyze the data:

- **company_dim**: Contains details about companies, including company ID, name, and links.
- **skills_dim**: Stores information about skills, including skill ID, name, and type.
- **job_postings_fact**: Captures job postings data with fields such as job ID, company ID, job title, location, posted date, and salary information.
- **skills_job_dim**: A junction table linking jobs and skills with job ID and skill ID as foreign keys.

The relational database can be visualised using the table schemas below:
![Table Schema for Job Postings](assest\Table Schema.png)

## Tools I Used:

#### **SQL**
- **Role**: The backbone of the analysis
- **Usage**: Crafted and executed intricate queries to extract and analyze job market data, uncovering critical insights into top-paying jobs, essential skills, and job trends.

#### **PostgreSQL**
- **Role**: Database Management System
- **Usage**: Managed and queried the comprehensive job postings database, ensuring efficient data handling and retrieval.

#### **Visual Studio Code**
- **Role**: Integrated Development Environment (IDE)
- **Usage**: Streamlined database management and SQL query execution, enhancing productivity and precision in data analysis.

#### **Git & GitHub**
- **Role**: Version Control and Collaboration Platform
- **Usage**: Ensured seamless version control and collaboration by tracking changes, sharing SQL scripts, and managing the project through branches and pull requests.

---

This powerful toolkit enabled a thorough exploration of the data analyst job market, revealing key trends and insights with precision and clarity.


## The Analysis:

Each query has been aimed at answering a specific question related to the data job market. In many cases, I have focussed on mainly Data Analyst Remote jobs.

### Top 20 Companies by Job Postings:

Top 20 Companies by Job Postings and Average Salaries: Identifies the leading companies with the most job listings and calculates their average offered salaries.

```sql
-- Finding the top 10 companies with the most job postings and getting the average salaries being offered:

SELECT 
    name, 
    COUNT(*) AS num_jobs, 
    ROUND(AVG(salary_year_avg), 2) AS avg_salary
FROM job_postings_fact jpf
JOIN company_dim cd ON jpf.company_id = cd.company_id
GROUP BY jpf.company_id, name
ORDER BY num_jobs DESC
LIMIT 20;
```

***Analysis:***



### Top 10 Companies for Data Analyst Positions: 
Focuses on companies with the highest number of job postings specifically for Data Analyst roles, along with their average salaries.


```sql
-- Specifically for Data Analysts:

SELECT 
    name, 
    COUNT(*) AS num_jobs, 
    ROUND(AVG(salary_year_avg), 2) AS avg_salary
FROM job_postings_fact jpf
JOIN company_dim cd ON jpf.company_id = cd.company_id
WHERE job_title_short='Data Analyst'
GROUP BY jpf.company_id, name
ORDER BY num_jobs DESC
LIMIT 10;
```

***Analysis:***

