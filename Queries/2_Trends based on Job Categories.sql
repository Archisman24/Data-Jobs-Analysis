-- Number of jobs based on job categories:

    SELECT 
        job_title_short,
        job_schedule_type,
        job_work_from_home,
        COUNT(job_id) AS Number_Of_Jobs
    FROM job_postings_fact
    GROUP BY job_title_short, job_schedule_type, job_work_from_home
    ORDER BY Number_Of_Jobs DESC;

-- Determining which skills are most commonly required in job categories such as data analysis, data engineering, and data science:

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
    WHERE job_category NOT IN ('Other')
    GROUP BY jc.job_category, s.skills
    ORDER BY jc.job_category ASC, num_jobs DESC;