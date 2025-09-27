-- Goal: Find which day of the week has the most number of trips

SELECT 
    DAYNAME(DATE(CONCAT(dd.tripYear, '-', dd.tripMonth, '-', dd.tripDay))) AS weekdays,
    COUNT(*) AS trip_count
FROM taxi_schema.taxi_route_details trd
JOIN date_dimension dd ON trd.tripID = dd.tripID
GROUP BY DAYNAME(DATE(CONCAT(dd.tripYear, '-', dd.tripMonth, '-', dd.tripDay)))
ORDER BY trip_count DESC
