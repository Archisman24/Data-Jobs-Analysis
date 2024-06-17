COPY company_dim
FROM 'D:\Learning\Codes\SQL\Job Analysis Project\Data Files\csv_files\company_dim.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

COPY skills_dim
FROM 'D:\Learning\Codes\SQL\Job Analysis Project\Data Files\csv_files\skills_dim.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

COPY job_postings_fact
FROM 'D:\Learning\Codes\SQL\Job Analysis Project\Data Files\csv_files\job_postings_fact.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

COPY skills_job_dim
FROM 'D:\Learning\Codes\SQL\Job Analysis Project\Data Files\csv_files\skills_job_dim.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');


-- Looking at the Tables:

SELECT * FROM company_dim;
SELECT * FROM skills_dim;
SELECT * FROM job_postings_fact;
SELECT * FROM skills_job_dim; 


