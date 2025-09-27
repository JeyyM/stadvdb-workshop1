-- Goal: Find which day of the week has the most number of trips
-- Using the date_dimension table to get day of the week is not ideal 
-- since it would result in additional processes

SELECT 
    DAYNAME(STR_TO_DATE(tpep_pickup_datetime, '%c/%e/%Y %l:%i %p')) AS weekdays,
    COUNT(*) AS trip_count
FROM taxi_schema.taxi_route_details
GROUP BY DAYNAME(STR_TO_DATE(tpep_pickup_datetime, '%c/%e/%Y %l:%i %p'))
ORDER BY trip_count DESC
