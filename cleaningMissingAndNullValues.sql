-- Data cleaning based on the generated EDA report.

--1) In the column 'children' there are some NA values and NULL values

--First check how many unknown values 
select distinct children, count(children)
from bookings
group by (children)

-- Since number of missing values is only 4, so rather than removing the column 
--we can remove the respective rows. And removing 4 rows out of 119390 rows will not affect the data.

delete from bookings 
where children is null or children = 'NA'

--Now recheck the counts
select distinct children, count(children)
from bookings
group by (children)
--Its all good now.
--Now it has only numerical values to convert it into integer data type.
alter table bookings 
alter column children type int using children::integer;

--2) Column agent has 13.1% missing values, so its better to remove the column
--First check the % of missing values
select count(*)
from bookings
where agent is null;

--So its better to drop the column
alter table bookings 
drop column agent

-- 3) Column company has 94% missing values , so its better to remove the column 
--Check the count
select count(*)
from bookings
where company is null;

--Remove the column 
alter table bookings
drop column company



