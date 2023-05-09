# <p align="center" style="margin-top: 0px; ">  Exploring Data Science Salaries in 2023 using SQL

  ![data science](https://user-images.githubusercontent.com/116097143/236707409-3ba318d7-66f0-4aba-9304-ea9250599933.png)

## INTRODUCTION
The purpose of this project is to analyze and explore the Data Science Salaries in 2023
dataset available on [Kaggle](https://www.kaggle.com/datasets/saurabhshahane/data-science-jobs-salaries). 
This dataset contains information about data science
salaries from different regions, companies, positions, and other factors that affect
salaries. The objective is to gain insights and identify trends from the data that can help
companies and individuals make informed decisions.

## Objectives
The objectives of this project are:
  
● Analyze the distribution of data science salaries in 2023
  
● Identify the factors that affect data science salaries such as job title, region, and company size
  
● Create visualizations to help understand the data better
  
● Identify the top-paying companies and job titles
  
● Explore the correlation between years of experience and salary
  
## Data Source
The dataset contains data from 10,000 respondents and was collected through a survey. The data is available in a CSV file format and contains 11 columns.

## Methodology
The project will involve the following steps:
  
1. Data cleaning and preparation: 
The dataset will be imported into a SQL database, cleaned and prepared for analysis. 
This includes dealing with missing data, removing duplicates, and converting data types as needed.
  
### a. CHECKING FOR MISSING VALUES IN EACH COLUMNS

Steps:

* Using **COALESCE** will return all rows where any of the specified columns contain a null value.

```sql
SELECT *
FROM [DS SALARIES].[dbo].[data_science_salaries ]
WHERE COALESCE(work_year, experience_level, employment_type, job_title, salary, 
               salary_currency, salary_in_usd, employee_residence, remote_ratio, company_location, company_size) IS NULL;        
```
### Output:
		
**work_year** | **experience_level** | **employment_type** | **job_title** | **salary** | **salary_currency**** | **salary_in_usd** | **employee_residence** | **remote_ratio** | **company_location** | **company_size** |
--- | --- | --- | --- | --- | ---| --- | --- | --- | --- | ---



There are no missing values in our data.
  
 ---
### b. CHECKING FOR DUPLICATE VALUES AND REMOVING THEM

Steps:

* Using **ROW_NUMBER** will assign a unique row number to each row within the specified columns listed,and the **rn** column is added to the result set to show the row number for each row. If there are duplicate rows in the table, the rn column will have a value greater than 1 for those rows. You can then use a WHERE clause to filter the results to only show the duplicate rows.

```sql
SELECT *
FROM (
    SELECT *, ROW_NUMBER() OVER (PARTITION BY work_year, experience_level, employment_type, job_title, salary, 
           salary_currency, salary_in_usd, employee_residence, remote_ratio, 
	       company_location, company_size ORDER BY (SELECT NULL)) AS rn
    FROM [DS SALARIES].[dbo].[data_science_salaries ]
) t
WHERE rn > 1       
```
### Output:
	
*Kindly note that this is not the entire output. This is just the first 10.*
		
| **work_year** | **experience_level** | **employment_type** | **job_title** | **salary** | **salary_currency** | **salary_in_usd** | **employee_residence** | **remote_ratio** | **company_location** | **company_size** | **rn**
 |  ---  | --- | --- | --- | --- | ---| --- | --- | --- | --- | --- | ---
 2020 | EN  | FT  | Data Engineer | 1000000 | INR | 13493  | IN  |  100 |  IN   |  L   | 2
 2021 | MI  | FT  | Data Engineer | 200000  | USD | 200000 | US  |  100 |  US   |  L   | 2
 2021 | MI  | FT  | Data Scientist| 76760   | EUR | 90734  | DE  |  50  |  DE   |  L   | 2
 2022 | EN  | FT  | Data Analyst  | 50000   | USD | 50000  | US  |  50  |  US   |  L   | 2	
 2022 | EN  | FT  | Data Engineer | 135000  | USD | 135000 | US  |  0   |  US   |  M   | 2
 2022 | EN  | FT  | Data Engineer | 135000  | USD | 135000 | US  |  0   |  US   |  M   | 3	
 2022 | EN  | FT  | Data Engineer | 135000  | USD | 135000 | US  |  0   |  US   |  M   | 4	
 2022 | EN  | FT  | Data Engineer | 135000  | USD | 135000 | US  |  0   |  US   |  M   | 5	
 2022 | EN  | FT  | Data Engineer | 135000  | USD | 135000 | US  |  0   |  US   |  M   | 6
 2022 | EN  | FT  | Data Engineer | 160000  | USD | 135000 | US  |  0   |  US   |  M   | 2	
	
There are so many duplicate values in our output, so we have to delete them
* Using **DELETE** to removes any rows where the **rn** value is greater than 1, will effectively delete all duplicate rows	
> **Deleting** data from a table can have unintended consequences, and it's generally a good practice to make a backup of the table before performing the delete operation. Additionally, it's a good idea to test the query on a smaller dataset or a copy of the original table before running it on the entire dataset to ensure that it works as expected.
	
```sql
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
```
### Output: 
	
Successfully
	
*Kindly note that if you rerun this code below*
	
```sql
SELECT *
FROM (
    SELECT *, ROW_NUMBER() OVER (PARTITION BY work_year, experience_level, employment_type, job_title, salary, 
           salary_currency, salary_in_usd, employee_residence, remote_ratio, 
	       company_location, company_size ORDER BY (SELECT NULL)) AS rn
    FROM [DS SALARIES].[dbo].[data_science_salaries ]
) t
WHERE rn > 1       
```
*the result will show an empty dataset, indicating no duplicate values available*
		
| **work_year** | **experience_level** | **employment_type** | **job_title** | **salary** | **salary_currency** | **salary_in_usd** | **employee_residence** | **remote_ratio** | **company_location** | **company_size** | **rn**
 |  ---  | --- | --- | --- | --- | ---| --- | --- | --- | --- | --- | ---
---	
### c. CHECKING THE DATA TYPE IN MY DATASET AND UPDATING DATA TYPE COLUMNS IF NECESSARY

Steps:

* The **INFORMATION_SCHEMA.COLUMNS** is a system view in SQL Server that provides metadata about the columns in a database. Using this view, you can retrieve information such as column names, data types, and maximum lengths for any table in the database. By filtering on the **TABLE_NAME** column. Here I included **USE** statement to specify which database I want to query, Without it, SQL Server will assume I am trying to query the default database (usually "master") and  may not get the expected results.

```sql
USE [DS SALARIES]
SELECT 
    COLUMN_NAME,
    DATA_TYPE,
    CHARACTER_MAXIMUM_LENGTH
FROM
    INFORMATION_SCHEMA.COLUMNS
WHERE 
    TABLE_NAME = 'data_science_salaries'
```
### Output:

| **COLUMN_NAME** | **DATA_TYPE** | **CHARACTER_MAXIMUM_LENGTH** 
 |  ---  | --- | --- | 
 work_year |varchar  | 50 | 
 experience_level |varchar  | 50 |
 employment_type | varchar  | 50 |
 job_title |varchar  | 50 |
salary	| varchar  | 50 |
 salary_currency |varchar  | 50 |
 salary_in_usd | varchar  | 50 |	
 employee_residence | varchar  | 50 |	
 remote_ratio | varchar  | 50 |
 company_location |varchar  | 50 |
 company_size | varchar  | 50 |

Some of our data are in a wrong data type, which will be difficult to work on during exploratory analysis, lets update our data using the syntax below
		
Steps:

* The **ALTER TABLE** is used to modify the structure of an existing table, such as adding or removing columns, changing data types, and modifying constraints.
	
```sql	
ALTER TABLE data_science_salaries
ALTER COLUMN work_year INT;

ALTER TABLE data_science_salaries
ALTER COLUMN salary INT;

ALTER TABLE data_science_salaries
ALTER COLUMN salary_in_usd INT;

ALTER TABLE data_science_salaries
ALTER COLUMN remote_ratio INT;
```	
### Output: 
	
Successfully
	
*Let's rerun this code below to confirm*	
```sql
USE [DS SALARIES]
SELECT 
    COLUMN_NAME,
    DATA_TYPE,
    CHARACTER_MAXIMUM_LENGTH
FROM
    INFORMATION_SCHEMA.COLUMNS
WHERE 
    TABLE_NAME = 'data_science_salaries'
```
### Output:

| **COLUMN_NAME** | **DATA_TYPE** | **CHARACTER_MAXIMUM_LENGTH** 
 |  ---  | --- | --- | 
 work_year |int  | NULL | 
 experience_level |varchar  | 50 |
 employment_type | varchar  | 50 |
 job_title |varchar  | 50 |
salary	| int  | NULL |
 salary_currency |varchar  | 50 |
 salary_in_usd | int  | NULL |	
 employee_residence | varchar  | 50 |	
 remote_ratio | int  | NULL |
 company_location |varchar  | 50 |
 company_size | varchar  | 50 |	
	
