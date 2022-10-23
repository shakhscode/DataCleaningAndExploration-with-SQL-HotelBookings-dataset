select * from bookings
--Now lets explore the data to answer the following questions

-- Qn.1) What is the busiest month, i.e in which month highest bookings were done ?
select arrival_date_month, count(*)
       from bookings 
	   group by arrival_date_month
	   order by count(*) desc;
--Answer: August and July are the busiest month

-- Qn. 2) Whether in weeknight or in weekend nigths number of customers are higher ?
select hotel, sum(stays_in_week_nights) as week_nights, sum(stays_in_weekend_nights) as weekend_nights
from bookings 
group by hotel
order by 1 desc
--Answer: Stays were higher in week nights

-- Qn.3) What kind of hotel is mostly preffered , city hotel or resort hotel ?
select hotel, count(*)
       from bookings 
	   group by hotel
	   order by count(*) desc;
-- Answer: City hotels were booked the most.

-- Qn. 4)  What is the mostly reserved room type?
select reserved_room_type, count(*)
       from bookings 
	   group by reserved_room_type
	   order by count(*) desc;
-- Answer: Room type 'A' were booked the most.

-- Qn. 5) What is the mostly used way to book a hotel?
select market_segment, count(*)
       from bookings 
	   group by market_segment
	   order by count(*) desc;
-- Answer: Ontile TA

-- Qn. 6) How many customers carry babies or children with them?
select count(*) as stays_with_children_babies, children, babies from bookings
where children > 0 or babies>0
group by children, babies
order by 1 desc

