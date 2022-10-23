# Data Cleaning and Exploration with SQL-Hotel Bookings Dataset

### Aim of the project.
- Cleaning and preparing a messy dataset for analysis.
- Building SQL logic for data cleaing operations like cleaning missing values, duplicate values etc.
- Expploratory data analysis using SQL.
### Used tools
- SQL (PostgreSQL)
- Python-Pandas, Psycopg2 (VS Code)

**pyscopg2 is a python library used to connect and interact with Postgre databases.**

To download psycopg2
```
sudo apt update
pip3 install psycopg2
```
***
## Detailed Explanations
### Contents of the repository

[Motivation](#motivation)

[Used dataset](#used-dataset)

[Step 1: Creating a database and a dynamic table](#step-1-creating-a-database-and-a-dynamic-table)

[Step 2: Import the values into the created table](#step-2-import-the-values-into-the-created-table)

[Step 3: Checking and changing data types](#step-3-checking-and-changing-data-types)

[Step 4: Data cleaning](#step-4-data-cleaning)

[4.1 Checking and cleaning Null values](#41-checking-and-cleaning-null-values)

>> [4.1.1 Checking for Null values](#411-checking-for-null-values)

>>[4.1.2 Cleaning the missing and null values](#412-cleaning-the-missing-and-null-values)

[4.2 Checking and cleaning duplicate values](#42-checking-and-cleaning-duplicate-values)

## Motivation 
- In an end to end data analytics project **data cleaning and data exploration** are two important steps. Unless the data is cleaned we can't discover  actual insights from the data.

- I mostly use Excel Power query for data cleaning. [(You can see one of my my data analysis project where I used Excel Power Query for data cleaning.)](https://github.com/shakhscode/Inflation-and-GDP-Growth-Analysis-G20Countries#inflation-and-gdp-growth-analysis-g20-countries), but for huge amount of data or for high dimensional data Excel.
-Comparatively SQL engine is faster than Excel and with SQL we can implement advanced logic for a task.

So I decided to do some data cleaning using SQL to sharpen my SQL logic.

## Used dataset
The dataset is collected from [Kaggle](https://www.kaggle.com/datasets/jessemostipak/hotel-booking-demand). Its a hotel booking dataset with total 32 fields and 119390 rows. It is an ideal dataset for data cleaning practices as it contains lot of null values,missing values and errorneous data.

[The collected data set in csv format before cleaning](hotel_bookings.csv).

## Step 1: [Creating a database and a dynamic table](CreateDatabaseAndImportData.ipynb)
- The collected dataset is in __.csv format. We can insert data from csv file into a SQL database but for this **first we need to create a table with simillar column names**, 
- Till now SQL databases can't create a table automatically from a csv file. 

- For a dataset with few no. of columns (lets say 4 or 5) we can create a table manually, but for a high dimensional dataset the manual process will consume lot of time. 
- The selected dataset contains total 32 columns, so its not a good idea to create a table manually to add 32 columns.
- So I used [psycopg2](https://www.psycopg.org/docs/) API to interact with PostgreSQL database using python and to automate the process to create a dynamic table with dynamic column names and data types.

#### Function to create a dynamic table with dynamic column names
```
createTable(name='TableName', 
            allcolumns=list_of_extracted_columns,alldatatypes=list_of_extracted_datatypes)
```

The function I created [(see this file)](CreateDatabaseAndImportData.ipynb) can create a dynamic table in a database with dynamic column names and data types extracted from csv file using pandas. In such a way we can automate the process to create a table in a database form a csv file.


## Step 2: Import the values into the created table
- We can also automate the process to insert values to a database table from csv file using psycopg2. For this we need to write atleast 30 lines of code. 

- But using 'pgadmin' I can easily insert the values from a csv file just using 'Import/Export Data' option. 

When I can do something easily and quickly, why should I choose the lengthiest way ! This is my philosophy and I am little bit lazy :) :)

So I imported values using the GUI option in pgadmin.

## Step 3: [Checking and changing data types](ChangeDataTypes.sql)
From the csv file, pandas extracted column data types as 'int64', 'float64' and 'objects'. But in SQL, data types are identified as 
'integer', 'float' or 'double precision'. Although the [function I created](CreateDatabaseAndImportData.ipynb) can fix change 'int64' to 'integer', 'float64' to 'double precision' but all other data types (like string, date_time, boolean) were identified as 'Objects' by pandas and were changed to 'varchar' when the table was created.

So now, its time to check the columns (there are total 5 columns with wrong data types) to correct the respective data types if required. 

[Checking and changing data types](ChangeDataTypes.sql)

## Step 4: Data cleaning

### 4.1 Checking and cleaning Null values

### 4.1.1 Checking for Null values
Normally following SQL query helps to find the number of null values present in a column.
```
SELECT count(*) FROM Table
WHERE column is NULL;
```
But for a high dimensional dataset it is not possible to check null values in each column one by one. 

#### Way 1: Using PL/SQL Procedure
I created a PL/SQL procedure that can check presence of NULL values in all column, doesn't matter how many columns a dataset has.

PL/SQL Procedure to count null values in all columns

```
--Count column wise number of NULL values.
create or replace procedure columnWiseNullCount(total_columns int)
language plpgsql
as $$
declare 
total_columns int = total_columns;
columnName varchar(50);
total_nulls int;

begin 
	 
     for i in 1..total_columns
	 loop
	 --Select a column 
	 SELECT Column_name into columnName
            FROM information_schema.columns
            where table_name = 'bookings'
            limit 1
			offset i-1;
	--Count the null values in that column
	
	 select count(*) from bookings into total_nulls
               where columnName is null;
	 
	if total_nulls > 0 then
	raise notice ' %, NULLs: %',columnName, total_nulls;
	end if;

	 end loop;

end;
$$
```
#### Way 2: Using Python Auto EDA libraries
If we need to create a PL/SQL procedure for each task it will take a long time. So using the logic-"If I can do something easily, why should I work hard ?

So rather than working hard lets work smart. 
Lets import the data set into Python IDE and using Pandas-profiling lets generate an automated EDA report.

```
#import the libraries
import pandas as pd
import pandas_profiling as pf

# import the dataset
df = pd.read_csv('hotel_bookings.csv')

report = pf.ProfileReport(df,explorative=True, dark_mode=True)
report.to_file('report.html')
```
We can host the report.html file in local server and based on the report we can do whatever need to do with this dataset.

### 4.1.2 Cleaning the missing and null values
[Check the file how I cleaned the missing values and null values](cleaningMissingAndNullValues.sql)

### 4.2 Checking and cleaning Duplicate values
