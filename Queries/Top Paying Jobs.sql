/*
    What are the top paying Data Analyst jobs?
    - Identifying the top 10 highest paying Data Analyst roles that are available remotely.
    - Focusses on job postings with specified salaries (remove nulls).
    - Why? Highlight the top-paying opportunities for Data Analysts, offering insights into 
*/

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
    AND job_location = 'Anywhere' 
    AND salary_year_avg IS NOT NULL
ORDER BY 
    salary_year_avg DESC
LIMIT 10;