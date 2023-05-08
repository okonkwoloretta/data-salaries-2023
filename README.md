# Analyzing Data Science Salaries for 2023 using SQL and PowerBI

![data science](https://user-images.githubusercontent.com/116097143/236707409-3ba318d7-66f0-4aba-9304-ea9250599933.png)

## INTRODUCTION
We are a team of data enthusiasts who wants to enhance our data skills by working on a project that involves cleaning, analyzing data using SQL, and visualizing the results using any tool of our choice...

## What is Data Science
Data Science is a multidisciplinary approach that combines principles and practices from the fields of mathematics, statistics, artificial intelligence, and computer engineering to analyze large amounts of data.

> Data Science process typically involves several stages, including:

- Problem formulation: Defining the problem, identifying the business goals and objectives, and determining what questions need to be answered.

- Data collection: Gathering relevant data from various sources, including structured and unstructured data, and cleaning and organizing it to ensure its quality and integrity.

- Data exploration and preparation: Exploring the data to identify patterns, relationships, and anomalies, and preparing the data for analysis.

- Data analysis: Using statistical and machine learning techniques to identify patterns, correlations, and insights within the data.

- Modeling and evaluation: Developing models that can be used to predict future outcomes or make informed decisions and evaluating their performance.

- Communication and visualization: Communicating the results of the analysis to stakeholders and presenting the findings in an accessible and understandable way using visualization tools.

Overall, data science has become increasingly important in today's data-driven world, with applications across a wide range of fields including healthcare, finance, marketing, and many others.

we will be exploring and finding insights from our dataset called **data science salaries 2023**, the data set can be found [here](https://www.kaggle.com/datasets/saurabhshahane/data-science-jobs-salaries)

## Data Cleaning and Preprocessing 

First lets have a preview of our dataset

![preview of the dataset](https://user-images.githubusercontent.com/116097143/236707871-41fc27b3-08c0-4912-9173-b9669fb56914.png)

1 Checked for missing values, Our data was from missing values

![preprocessing](https://user-images.githubusercontent.com/116097143/236708524-5df8b618-f10a-4b23-8f04-d670b161d136.png)
![preprocessing 2](https://user-images.githubusercontent.com/116097143/236708532-cf542ea0-7227-4fc1-a8d3-1d2ee707855f.png)
![preprocessing 3](https://user-images.githubusercontent.com/116097143/236708536-feca74e2-a8b6-4140-932a-7166485777c5.png)



2 Checking for duplicates with the following code

![checking for dup](https://user-images.githubusercontent.com/116097143/236708645-94cdd523-c1cc-4e16-af62-73c703f2dc0f.png)

and discovered there were alot a of duplicate values

![dup7](https://user-images.githubusercontent.com/116097143/236708036-73bb0c4f-731e-485d-a27b-7f45ff4f1039.png)

![dup6](https://user-images.githubusercontent.com/116097143/236708048-b79be33e-741f-4a2a-adf6-65136aafa48a.png)

![dup4](https://user-images.githubusercontent.com/116097143/236708058-b86ce737-3905-43ae-b56c-47528963cc10.png)

![dup3](https://user-images.githubusercontent.com/116097143/236708067-e8fac801-2ff3-4a91-9af2-1b2c1840c9f1.png)

> Note: it is not a standard practice to delete data from a dataset without permission from the owner of the data. Data ownership and privacy are essential considerations in any data-related project or analysis.

Deleting data without permission can lead to legal and ethical issues, such as violating data privacy laws or breaching confidentiality agreements. It can also negatively impact the accuracy and completeness of the dataset, potentially leading to biased or incorrect analysis.

If there is a legitimate reason to remove certain data from a dataset, it should be done in a transparent and responsible manner, with proper justification and documentation. It is also important to ensure that the dataset remains representative and unbiased after removing the data, and that any necessary adjustments or corrections are made to account for the missing data.

Overall, the responsible handling of data is critical for maintaining trust and credibility in the field of data science.

I have to remove duplicate values, as this is a practice work using this code below

![removing dup column](https://user-images.githubusercontent.com/116097143/236708585-d49a2bdb-b276-470a-a0ce-f6cb09a62604.png)

3 Checking my data type

![checking datatype](https://user-images.githubusercontent.com/116097143/236708953-70b6584d-5776-49e6-8709-6c3542ac64d0.png)

Wow, I just discovered all the columns were converted to **varchar** this happens when the dataset was not imported properly , lets fixed that up using

![updated data type](https://user-images.githubusercontent.com/116097143/236709124-d0d444de-c99f-4aa3-acf2-e849e633ef1a.png)

lets us preview our updated data type

![updated data type](https://user-images.githubusercontent.com/116097143/236709066-946a8cf0-a79a-442e-a2bc-cd00ada76a04.png)

## Exploratory data analysis (EDA)
lets explore our data by answering the following questions
1. 
![avg salary](https://user-images.githubusercontent.com/116097143/236709315-b1d52f91-d9f8-4668-a3ae-e839ad1fd8c6.png)

2.
![median salary](https://user-images.githubusercontent.com/116097143/236709446-e2d3f775-6cc4-4d34-9bed-225dd6b25b06.png)

3.
![max and min salary](https://user-images.githubusercontent.com/116097143/236709443-41fa95a2-e279-4068-a08c-b68c8226aa22.png)

4.
![distribution of salaries ](https://user-images.githubusercontent.com/116097143/236709450-f6499148-8042-4245-a43f-d4390cf7eaf4.png)

5.
![region highest salary](https://user-images.githubusercontent.com/116097143/236709768-ae2fea95-6bdc-4f04-9bd2-2e331b23c6dc.png)



![region with data science job](https://user-images.githubusercontent.com/116097143/236709447-0d00f451-c8b4-4196-b7f0-65dce3a1473e.png)

6.
![salary,level experience ](https://user-images.githubusercontent.com/116097143/236709448-fd2fc014-970f-45d2-82e0-c2d57f25edbd.png)

7.
![comp size salary](https://user-images.githubusercontent.com/116097143/236709449-13465219-8692-4ba9-8409-1e76e325831d.png)

8.
![job title highes salary](https://user-images.githubusercontent.com/116097143/236709451-00605f37-1987-4482-b06a-3d188373acfc.png)
