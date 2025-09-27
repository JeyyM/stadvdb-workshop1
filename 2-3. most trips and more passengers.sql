-- Which vendor got the most trips per month?
-- naive solution 
SELECT trd.VendorID, dd.tripMonth, COUNT(*) AS trip_count
FROM taxi_route_details AS trd
JOIN date_dimension AS dd
  ON trd.tripID = dd.tripID
GROUP BY dd.tripMonth, trd.VendorID
ORDER BY trip_count DESC;

-- optimized, create a fact table - usually used for repetitive tasks, but since no limit on storage, it is much faster :)
DROP TABLE IF EXISTS trip_fact;
create table trip_fact (
tripID bigint primary key,
vendorID int,
pickup_month int
);

insert into trip_fact (tripID, VendorID, pickup_month)
select taxi_route_details.tripID, vendorID, date_dimension.tripMonth
from taxi_route_details
join date_dimension
  on taxi_route_details.tripID = date_dimension.tripID;

select vendorID, pickup_month, COUNT(*) AS trip_count
from trip_fact
group by pickup_month, vendorID
order by trip_count desc;


-- Are taxis earning more if they have more passengers? 
-- naive solution
SELECT passenger_count, AVG(total_amount) as average_earning
FROM taxi_route_details AS trd
JOIN taxi_payment_details AS tpd
  ON trd.tripID = tpd.tripID
GROUP BY trd.passenger_count
ORDER BY average_earning DESC;

-- optimized, same idea since indexes either dont optimize much or make it slower, creating a fact table with our unrestricted storage is just much much faster.
-- other notes are tiny optimizations in stuff like not using AS and just directly calling it, barely makes a difference but its there i guess
DROP TABLE IF EXISTS earnings_fact;
create table earnings_fact (
tripID bigint primary key,
passenger_count int,
total_amount float
);

insert into earnings_fact (tripID, passenger_count, total_amount)
select taxi_route_details.tripID, passenger_count, taxi_payment_details.total_amount
from taxi_route_details
join taxi_payment_details 
	on taxi_route_details.tripID = taxi_payment_details.tripID;

select passenger_count, avg(total_amount) as average_earnings
from earnings_fact
group by passenger_count
order by average_earnings desc;
