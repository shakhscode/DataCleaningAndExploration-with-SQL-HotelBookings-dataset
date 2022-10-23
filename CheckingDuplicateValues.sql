select * from bookings

--Here arraival date is separated into date, month and year.
--Lets concat them into a single column and change the data type.

--For this first create a new column 'arrival_date'
alter table bookings
add column arrival_date date

--Now concat the date,month,year into asingle column and convert them into date data type.
-- And enter to the newly created column 'arrival_date'

update bookings 
set arrival_date = cast(concat(arrival_date_day_of_month,'-',
						arrival_date_month,'-',arrival_date_year) as date)

-- Find duplicate entries using CTID. Since CTID is unique for each row, so it will show exact duplicates.
SELECT COUNT(*)
FROM bookings
GROUP BY ctid
HAVING COUNT(*) > 1
--It shows that there are no exact duplicate entries.