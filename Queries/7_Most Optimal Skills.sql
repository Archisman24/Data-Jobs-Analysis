/*
    What are the most optimal skills to learn for data analysts?(aka it's high demand and a high paying skill)
    - Identify skills in high demand and associated with high average salaries for Data Analyst roles,
    - Concentrates on remote positions with specified salaries,
    - Why? Targets skills that offer job security (high demand) and financial benefits (high salaries),
    offering strategic insights for career development in data analysis.
*/

WITH skills_demand AS (
    SELECT
        skills_job_dim.skill_id,
        skills,
        COUNT(skills_job_dim.job_id) AS Number_Of_Jobs
    FROM job_postings_fact
    INNER JOIN skills_job_dim ON skills_job_dim.job_id = job_postings_fact.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE 
        job_title_short = 'Data Analyst'
        AND  job_work_from_home = TRUE
        AND salary_year_avg IS NOT NULL
    GROUP BY skills_job_dim.skill_id, skills_dim.skills
), average_salary AS (
    SELECT
        skills_job_dim.skill_id,
        skills,
        ROUND(AVG(salary_year_avg), 2) AS Average_Yearly_Salary
    FROM job_postings_fact
    INNER JOIN skills_job_dim ON skills_job_dim.job_id = job_postings_fact.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE 
        job_title_short = 'Data Analyst'
        AND salary_year_avg IS NOT NULL
        AND  job_work_from_home = TRUE
    GROUP BY skills_job_dim.skill_id, skills_dim.skills
)

SELECT
    skills_demand.skills,
    Number_Of_Jobs,
    Average_Yearly_Salary
FROM skills_demand
JOIN average_salary ON skills_demand.skill_id = average_salary.skill_id
ORDER BY Number_Of_Jobs DESC, Average_Yearly_Salary DESC
LIMIT 25;

-- Alternative Method:


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

 