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


-- Analyzing the change in demand for specific skills over time by comparing the number of job postings mentioning those skills each month:

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



