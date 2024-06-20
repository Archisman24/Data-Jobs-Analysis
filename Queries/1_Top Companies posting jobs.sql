-- Finding the top 20 companies with the most job postings and getting the average salaries being offered:

SELECT 
    name, 
    COUNT(*) AS num_jobs, 
    ROUND(AVG(salary_year_avg), 2) AS avg_salary
FROM job_postings_fact jpf
JOIN company_dim cd ON jpf.company_id = cd.company_id
GROUP BY jpf.company_id, name
ORDER BY num_jobs DESC
LIMIT 20;


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


