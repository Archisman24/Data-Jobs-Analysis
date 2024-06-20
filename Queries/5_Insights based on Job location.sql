-- Determining the number of job postings per country:

SELECT job_country, COUNT(*) AS num_jobs
FROM job_postings_fact
GROUP BY job_country
ORDER BY num_jobs DESC;

-- Finding the average salary based in each job location:

SELECT job_location, ROUND(AVG(salary_year_avg)) AS avg_salary
FROM job_postings_fact
WHERE salary_year_avg IS NOT NULL
GROUP BY job_location
ORDER BY avg_salary DESC;

