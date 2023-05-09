--CHECKING FOR MISSING VALUES in WORK YEAR COLUMN

SELECT *
FROM [DS SALARIES].[dbo].[data_science_salaries ] 
WHERE COALESCE(work_year, experience_level, employment_type, job_title, salary, 
               salary_currency, salary_in_usd, employee_residence, remote_ratio,
			   company_location, company_size) IS NULL

--CHECKING FOR DUPLICATE COLUMNS 
SELECT *
FROM (
    SELECT *, ROW_NUMBER() OVER (PARTITION BY work_year, experience_level, employment_type, job_title, salary, 
           salary_currency, salary_in_usd, employee_residence, remote_ratio, 
	       company_location, company_size ORDER BY (SELECT NULL)) AS rn
    FROM [DS SALARIES].[dbo].[data_science_salaries ]
) t
WHERE rn > 1

--REMOVING DUPLICATE VALUES USING CTE
WITH CTE AS (
  SELECT work_year, experience_level, employment_type, job_title, salary, 
         salary_currency, salary_in_usd, employee_residence, remote_ratio, 
         company_location, company_size,
         ROW_NUMBER() OVER (
           PARTITION BY work_year, experience_level, employment_type, job_title, salary, 
                        salary_currency, salary_in_usd, employee_residence, remote_ratio, 
	                    company_location, company_size
           ORDER BY (SELECT 0)
         ) AS rn
  FROM [DS SALARIES].[dbo].[data_science_salaries ]
)

DELETE FROM CTE
WHERE rn > 1;

--CHECKING THE DATA TYPE IN MY DATASET
USE [DS SALARIES]
SELECT 
    COLUMN_NAME,
    DATA_TYPE,
    CHARACTER_MAXIMUM_LENGTH
FROM
    INFORMATION_SCHEMA.COLUMNS
WHERE 
    TABLE_NAME = 'data_science_salaries'

--UPDATING DATA TYPE COLUMNS
ALTER TABLE data_science_salaries
ALTER COLUMN work_year INT;

ALTER TABLE data_science_salaries
ALTER COLUMN salary INT;

ALTER TABLE data_science_salaries
ALTER COLUMN salary_in_usd INT;

ALTER TABLE data_science_salaries
ALTER COLUMN remote_ratio INT;

--RERUN TO COMFIRM
USE [DS SALARIES]
SELECT 
    COLUMN_NAME,
    DATA_TYPE,
    CHARACTER_MAXIMUM_LENGTH
FROM
    INFORMATION_SCHEMA.COLUMNS
WHERE 
    TABLE_NAME = 'data_science_salaries'

--EXPLORATORY DATA ANALYSIS
--average data science salary in 2023

SELECT AVG(salary_in_usd) AS avg_salary
FROM [DS SALARIES].[dbo].[data_science_salaries ]
WHERE work_year = '2023' AND job_title = 'Data Scientist'

--median data science salary in 2023

SELECT PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY salary_in_usd) OVER() AS median_salary
FROM [DS SALARIES].[dbo].[data_science_salaries ]
WHERE work_year = '2023' AND job_title = 'Data Scientist'

--highest and lowest salary in the dataset
SELECT MAX(salary_in_usd) AS max_salary, MIN(salary_in_usd) AS min_salary
FROM [DS SALARIES].[dbo].[data_science_salaries ]

-- distribution of salaries in the dataset
SELECT salary_in_usd, COUNT(*) AS count
FROM [DS SALARIES].[dbo].[data_science_salaries ]
WHERE salary_in_usd IS NOT NULL
GROUP BY salary_in_usd
ORDER BY salary_in_usd

-- region pays the highest salaries
SELECT employee_residence, AVG(salary_in_usd) AS avg_salary
FROM [DS SALARIES].[dbo].[data_science_salaries ]
GROUP BY employee_residence
ORDER BY avg_salary DESC

--region has the most data science jobs
SELECT employee_residence AS region, COUNT(*) AS job_count
FROM [DS SALARIES].[dbo].[data_science_salaries ]
WHERE job_title = 'Data Scientist'
GROUP BY employee_residence
ORDER BY job_count DESC

--top-paying companies location for data science roles
SELECT company_location, AVG(salary_in_usd) AS avg_salary
FROM [DS SALARIES].[dbo].[data_science_salaries ]
WHERE job_title = 'Data Scientist'
GROUP BY company_location
ORDER BY avg_salary DESC

--average salary for data scientists with different levels of experience
SELECT experience_level, AVG(salary_in_usd) AS avg_salary
FROM [DS SALARIES].[dbo].[data_science_salaries ]
WHERE job_title = 'Data Scientist'
GROUP BY experience_level
ORDER BY avg_salary DESC

--Which job titles have the highest salaries
SELECT job_title, AVG(salary_in_usd) AS avg_salary
FROM [DS SALARIES].[dbo].[data_science_salaries ]
WHERE work_year = '2023'
GROUP BY job_title
ORDER BY avg_salary DESC

--How does company size affect salaries for data science roles
SELECT company_size, AVG(salary_in_usd) AS avg_salary
FROM [DS SALARIES].[dbo].[data_science_salaries ]
WHERE job_title = 'Data Scientist' AND work_year = '2023'
GROUP BY company_size
ORDER BY avg_salary DESC



