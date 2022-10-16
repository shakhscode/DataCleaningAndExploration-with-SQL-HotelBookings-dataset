--see the table structure and have a quick look to the columns and column data types
select * from bookings

--Changes to be made
1)
--change the 'is_canceled' colummn into boolean type

alter table bookings
alter column is_canceled type bool USING is_canceled::boolean;

2)
-- Now we need to change the data type of 
--'arrival_date_year','arrival_date_month','arrival_date_day_of_month' into year, month , day respectively.
--Rather than doing this manually lets first concatenate them into one column 
--then we can use date/month/year whenever we need

--first create a new column
alter table bookings 
add arrival_date date;

--Now update it by the concatenated values
update bookings 
set arrival_date = cast(concat(arrival_date_year,'-', arrival_date_month,'-', arrival_date_day_of_month) as date);

--check the update 
select * from bookings limit 8

3)
--chnange the data type of children from varchar to integer
--first check waht are the distinct values
select distinct children from bookings
--Since ther is as a value NA, PostgreSQL does not interpret any meaning for NA, so lets change it to NULL
update bookings
set children = NULL
where children = 'NA'
--Now change the datatype

alter table bookings
alter column children type int using children::int;

select reservation_status_date from bookings limit 30

4)
-- column 'is_repeated_guest' seems like a boolean but here the type is integer
--Check the distinct values and if only 0 and 1 then change it to boolean
select distinct * from bookings
--Yes its boolean type so change it to boolean type
alter table bookings
alter column is_repeated_guest type bool using children::boolean;

5)
--Column 'reservation_status_date' is datetme data type but it was detected as varchar so change it to original data type
alter table bookings
alter column reservation_status_date type date using reservation_status_date::date;

--Check the updated table
select * from bookings limit 20

--Everything seems good , now its time to start data cleaning.