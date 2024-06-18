/*
Question : What skills are required for top-paying data analyst jobs?
- Use the top 10 highest paying Data Analyst roles that are available remotely,
- Add the specific skills required for each role,
- Why? => It provides a detailed look at which high-paying jobs demand certain skills, helping
  job seekers understand which skills to develop that align with top salaries.
*/

-- Using the previous query as a CTE:

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
        AND job_location = 'Anywhere' 
        AND salary_year_avg IS NOT NULL
    ORDER BY 
        salary_year_avg DESC
    LIMIT 10
)

SELECT 
    high_paying_jobs.*,
    skills_job_dim.skill_id,
    skills
FROM 
    high_paying_jobs
JOIN skills_job_dim ON skills_job_dim.job_id = high_paying_jobs.job_id
JOIN skills_dim ON skills_dim.skill_id = skills_job_dim.skill_id
ORDER BY 
    salary_year_avg DESC;


-- Getting to know average salary related to a skill and the number of jobs available:

SELECT
    skills_job_dim.skill_id,
    skills,
    AVG(salary_year_avg) AS Average_Yearly_Salary,
    COUNT(job_postings_fact.job_id) AS Number_of_Jobs
FROM
    job_postings_fact
JOIN skills_job_dim ON skills_job_dim.job_id = job_postings_fact.job_id
JOIN skills_dim ON skills_dim.skill_id = skills_job_dim.skill_id
WHERE salary_year_avg IS NOT NULL AND
    job_title_short = 'Data Analyst'
    AND job_location = 'Anywhere' 
GROUP BY
    skills_job_dim.skill_id, skills
ORDER BY
    Average_Yearly_Salary DESC