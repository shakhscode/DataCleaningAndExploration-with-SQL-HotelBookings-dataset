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
## Motivation 
- In an end to end data analytics project **data cleaning and data exploration** are two important steps. Unless the data is cleaned we can't discover  actual insights from the data.

- I mostly use Excel Power query for data cleaning. [(You can see one of my my data analysis project where I used Excel Power Query for data cleaning.)](https://github.com/shakhscode/Inflation-and-GDP-Growth-Analysis-G20Countries#inflation-and-gdp-growth-analysis-g20-countries), but for huge amount of data or for high dimensional data Excel.
-Comparatively SQL engine is faster than Excel and with SQL we can implement advanced logic for a task.

So I decided to do some data cleaning using SQL to sharpen my SQL logic.

## Used dataset
The dataset is collected from [Kaggle](https://www.kaggle.com/datasets/jessemostipak/hotel-booking-demand). Its a hotel booking dataset with total 32 fields and 119390 rows. It is an ideal dataset for data cleaning practices as it contains lot of null values,missing values and errorneous data.

[The collected data set in csv format before cleaning](hotel_bookings.csv).

## Used tools
- SQL - for data cleaning and exploration.

- Python - pandas, psycopg2 - to connect to the database and to create a dynamic table from the csv file.

## Step 1: Creating a database and a dynamic table.
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

## Step 3: Checking and changing data types
From the csv file, pandas extracted column data types as 'int64', 'float64' and 'objects'. But in SQL, data types are identified as 
'integer', 'float' or 'double precision'. Although the [function I created](CreateDatabaseAndImportData.ipynb) can fix change 'int64' to 'integer', 'float64' to 'double precision' but all other data types (like string, date_time, boolean) were identified as 'Objects' by pandas and were changed to 'varchar' when the table was created.

So now, its time to check the columns (there are total 5 columns with wrong data types) to correct the respective data types if required. 

[See this file for SQL queries to change the data types.](ChangeDataTypes.sql)

## Step 4: Data cleaning
