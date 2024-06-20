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

![Table Schema for Job Postings](assest\Table_Schema.png)

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

### 1. Top 20 Companies by Job Postings:

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



### 2. Top 20 Companies for Data Analyst Positions: 
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
LIMIT 20;
```

***Analysis:***

### 3. Job Distribution by Category and Type: 
Analyzes the number of job postings based on job categories, schedule types, and work-from-home options.

```sql
-- Number of jobs based on job categories:
SELECT 
    job_title_short,
    job_schedule_type,
    job_work_from_home,
    COUNT(job_id) AS Number_Of_Jobs
FROM job_postings_fact
GROUP BY job_title_short, job_schedule_type, job_work_from_home
ORDER BY Number_Of_Jobs DESC;
```

***Analysis:***


### 4. Top Skills in Key Data Roles: 
Identifies the most commonly required skills for Data Analyst, Data Engineer, and Data Scientist positions and also shows th number of jobs associated with each skills.

```sql
WITH JobCategories AS (
    SELECT job_id,
        CASE
            WHEN job_title ILIKE '%data analyst%' THEN 'Data Analyst'
            WHEN job_title ILIKE '%data engineer%' THEN 'Data Engineer'
            WHEN job_title ILIKE '%data scientist%' THEN 'Data Scientist'
            ELSE 'Other'
        END AS job_category
    FROM public.job_postings_fact
)
SELECT 
    jc.job_category, 
    s.skills, 
    COUNT(*) AS num_jobs
FROM JobCategories jc
JOIN skills_job_dim sj ON jc.job_id = sj.job_id
JOIN skills_dim s ON sj.skill_id = s.skill_id
GROUP BY jc.job_category, s.skills
ORDER BY jc.job_category ASC, num_jobs DESC;
```

***Analysis:***

### 5.Top 20 Highest Paying Remote Data Analyst Jobs: 
Identifies the top 20 highest paying remote Data Analyst roles with specified salaries.

```sql
-- Top 20 Data Analyst Remote jobs:
SELECT 
    job_id,
    name AS company_name,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date::DATE
FROM
    job_postings_fact
LEFT JOIN company_dim ON company_dim.company_id = job_postings_fact.company_id
WHERE
    job_title_short = 'Data Analyst' 
    AND (job_location = 'Anywhere' OR job_work_from_home=TRUE)
    AND salary_year_avg IS NOT NULL
ORDER BY 
    salary_year_avg DESC
LIMIT 20;
```

***Analysis:***

### 6. Skills Required for High Paying Data Analyst Jobs: 
Lists the skills required for these top-paying Data Analyst positions, mentioned above.

```sql
-- Skills required in these high paying jobs:
WITH high_paying_jobs AS (
    SELECT 
        job_id,
        job_title,
        salary_year_avg
    FROM
        job_postings_fact
    LEFT JOIN company_dim ON company_dim.company_id = job_postings_fact.company_id
    WHERE
        job_title_short = 'Data Analyst' 
        AND (job_location = 'Anywhere' OR job_work_from_home=TRUE)
        AND salary_year_avg IS NOT NULL
    ORDER BY 
        salary_year_avg DESC
    LIMIT 20
)

SELECT 
    high_paying_jobs.*,
    skills
FROM 
    high_paying_jobs
JOIN skills_job_dim ON skills_job_dim.job_id = high_paying_jobs.job_id
JOIN skills_dim ON skills_dim.skill_id = skills_job_dim.skill_id
ORDER BY 
    salary_year_avg DESC;
```

***Analysis:***

### 7. Top 10 Skills for Remote Data Analyst Jobs: 
Identifies the top 10 skills required for remote Data Analyst positions based on job postings and average salary.

```sql

-- Showing the top 10 skills required for data analyst remote jobs:  
SELECT 
    s.skill_id, 
    s.skills, 
    COUNT(*) AS num_jobs,
    ROUND(AVG(salary_year_avg), 2) AS avg_salary
FROM skills_dim s
JOIN skills_job_dim sj ON s.skill_id = sj.skill_id
JOIN job_postings_fact jpf ON sj.job_id = jpf.job_id
WHERE 
    job_title_short = 'Data Analyst'
    AND (job_location = 'Anywhere' OR job_work_from_home=TRUE)
    AND salary_year_avg IS NOT NULL
GROUP BY s.skill_id, s.skills
ORDER BY avg_salary DESC
LIMIT 10;
```

***Analysis:***

### 8. Job Postings by Country: 
Determines the number of job postings available in each country.

```sql
-- Determining the number of job postings per country:
SELECT job_country, COUNT(*) AS num_jobs
FROM job_postings_fact
GROUP BY job_country
ORDER BY num_jobs DESC;
```

***Analysis:***


### 9. Average Salary by Job Location: 
Calculates the average salary for job postings in various locations.

```sql
-- Finding the average salary based in each job location:
SELECT job_location, ROUND(AVG(salary_year_avg)) AS avg_salary
FROM job_postings_fact
WHERE salary_year_avg IS NOT NULL
GROUP BY job_location
ORDER BY avg_salary DESC;
```

***Analysis:***


### 10. Top 5 In-Demand Skills for Data Analysts: 
Identifies the five most sought-after skills for Data Analyst positions based on the number of job postings.

```sql
SELECT 
    skills,
    COUNT(skills_job_dim.job_id) AS Number_Of_Jobs
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE job_title_short = 'Data Analyst'
GROUP BY skills
ORDER BY Number_Of_Jobs DESC
LIMIT 5;
```

***Analysis:***


### 11. Top 25 Skills for Remote Data Analyst Jobs: 
Identifies the top 25 skills for remote Data Analyst positions, ranked by job frequency and average yearly salary.

```sql
SELECT
    skills,
    COUNT(job_postings_fact.job_id) AS Number_of_Jobs,
    ROUND(AVG(salary_year_avg), 2) AS Average_Yearly_Salary
FROM
    job_postings_fact
JOIN skills_job_dim ON skills_job_dim.job_id = job_postings_fact.job_id
JOIN skills_dim ON skills_dim.skill_id = skills_job_dim.skill_id
WHERE 
    salary_year_avg IS NOT NULL AND
    job_title_short = 'Data Analyst'
    AND  job_work_from_home = TRUE
GROUP BY
    skills_job_dim.skill_id, skills
ORDER BY
    Number_of_Jobs DESC, 
    Average_Yearly_Salary DESC
LIMIT 25;
```

***Analysis:***

### 12. Monthly Job Posting Trends: 
Tracks the monthly trend of job postings, indicating increases or decreases compared to the previous month.

```sql
-- Tracking the monthly trend of job postings, indicating whether it has increased or decreased compared to the previous month.

WITH MonthlyJobPostings AS 
(
    SELECT DATE_TRUNC('month', job_posted_date)::DATE AS month_start,
           COUNT(*) AS num_jobs
    FROM public.job_postings_fact
    GROUP BY month_start
    ORDER BY month_start
)
SELECT month_start,
    num_jobs,
    LAG(num_jobs) OVER (ORDER BY month_start) AS previous_month_jobs,
    CASE
        WHEN num_jobs > LAG(num_jobs) OVER (ORDER BY month_start) THEN 'Increase'
        WHEN num_jobs < LAG(num_jobs) OVER (ORDER BY month_start) THEN 'Decrease'
        ELSE 'No Change'
    END AS trend
FROM MonthlyJobPostings;
```


***Analysis:***


### 13. Skill Demand Trends Over Time: 
Analyzes the yearly changes in demand for specific skills by comparing the number of job postings mentioning those skills.

```sql
WITH SkillTrend AS (
    SELECT 
        s.skills,
        DATE_TRUNC('year', job_posted_date)::DATE AS posting_year,
        COUNT(*) AS num_jobs
    FROM job_postings_fact jf
    JOIN skills_job_dim sj ON jf.job_id = sj.job_id
    JOIN skills_dim s ON sj.skill_id = s.skill_id
    GROUP BY s.skills, posting_year
)
SELECT 
    skills, 
    posting_year,
    num_jobs,
    LAG(num_jobs) OVER (PARTITION BY skills ORDER BY posting_year) AS previous_year_jobs,
    CASE
        WHEN num_jobs > LAG(num_jobs) OVER (PARTITION BY skills ORDER BY posting_year) THEN 'Increase'
        WHEN num_jobs < LAG(num_jobs) OVER (PARTITION BY skills ORDER BY posting_year) THEN 'Decrease'
        ELSE 'No Change'
    END AS trend
FROM SkillTrend
ORDER BY skills, posting_year;
```

***Analysis:***



## What I Learned:


## Conclusions:


### References:
