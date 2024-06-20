/*
Question : What top skills are required for data analyst jobs?
*/

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
