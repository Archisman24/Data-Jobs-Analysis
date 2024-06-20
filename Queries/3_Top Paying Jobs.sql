/*
    What are the top paying Data Analyst jobs?
    - Identifying the top 20 highest paying Data Analyst roles that are available remotely.
    - Focusses on job postings with specified salaries (remove nulls).
*/
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
