
select * from bookings

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
	 
	 --if total_nulls > 0 then
	raise notice ' %, NULLs: %',columnName, total_nulls;
	 --end if;

	 end loop;

end;
$$


call columnWiseNullCount(32)



select count(*) from bookings 
where agent is null
