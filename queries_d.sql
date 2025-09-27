-- What are the peak hours per vendor per month? (NAIVE)
SELECT 
    r.VendorID,
    YEAR(STR_TO_DATE(r.tpep_pickup_datetime, '%Y-%m-%d %H:%i:%s')) AS trip_year,
    MONTH(STR_TO_DATE(r.tpep_pickup_datetime, '%Y-%m-%d %H:%i:%s')) AS trip_month,
    HOUR(STR_TO_DATE(r.tpep_pickup_datetime, '%Y-%m-%d %H:%i:%s')) AS trip_hour,
    COUNT(*) AS trip_count
FROM taxi_route_details r
GROUP BY r.VendorID, trip_year, trip_month, trip_hour
ORDER BY trip_year, trip_month, trip_count DESC;

-- What are the peak hours per vendor per month? (OPTIMIZED)
SELECT *
FROM (
    SELECT 
        r.VendorID,
        DATE_FORMAT(STR_TO_DATE(r.tpep_pickup_datetime, '%Y-%m-%d %H:%i:%s'), '%Y-%m') AS trip_month,
        HOUR(STR_TO_DATE(r.tpep_pickup_datetime, '%Y-%m-%d %H:%i:%s')) AS trip_hour,
        COUNT(*) AS trip_count,
        ROW_NUMBER() OVER (PARTITION BY r.VendorID, DATE_FORMAT(STR_TO_DATE(r.tpep_pickup_datetime, '%Y-%m-%d %H:%i:%s'), '%Y-%m')
                           ORDER BY COUNT(*) DESC) AS rn
    FROM taxi_route_details r
    GROUP BY r.VendorID, trip_month, trip_hour
) ranked
WHERE rn = 1;
