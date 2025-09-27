-- Goal: Find the average trip length in minutes per weekday
SELECT
    DAYNAME(STR_TO_DATE(tpep_pickup_datetime, '%c/%e/%Y %l:%i %p')) AS weekday,
    COUNT(*) AS trip_count,

    AVG(TIMESTAMPDIFF(MINUTE, 
        STR_TO_DATE(tpep_pickup_datetime, '%c/%e/%Y %l:%i %p'),
        STR_TO_DATE(tpep_dropoff_datetime, '%c/%e/%Y %l:%i %p')
    )) AS avg_minutes

FROM taxi_schema.taxi_route_details

GROUP BY DAYNAME(STR_TO_DATE(tpep_pickup_datetime, '%c/%e/%Y %l:%i %p')),
         DAYOFWEEK(STR_TO_DATE(tpep_pickup_datetime, '%c/%e/%Y %l:%i %p'))
ORDER BY DAYOFWEEK(STR_TO_DATE(tpep_pickup_datetime, '%c/%e/%Y %l:%i %p'));