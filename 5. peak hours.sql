-- What are the peak hours per vendor per month? (NAIVE)
SELECT 
    r.VendorID,
    dd.tripYear AS trip_year,
    dd.tripMonth AS trip_month,
    HOUR(STR_TO_DATE(r.tpep_pickup_datetime, '%Y-%m-%d %H:%i:%s')) AS trip_hour,
    COUNT(*) AS trip_count
FROM taxi_route_details r
JOIN date_dimension dd ON r.tripID = dd.tripID
GROUP BY r.VendorID, dd.tripYear, dd.tripMonth, trip_hour
ORDER BY dd.tripYear, dd.tripMonth, trip_count DESC;

-- What are the peak hours per vendor per month? (OPTIMIZED)
SELECT *
FROM (
    SELECT 
        r.VendorID,
        CONCAT(dd.tripYear, '-', LPAD(dd.tripMonth, 2, '0')) AS trip_month,
        HOUR(STR_TO_DATE(r.tpep_pickup_datetime, '%Y-%m-%d %H:%i:%s')) AS trip_hour,
        COUNT(*) AS trip_count,
        ROW_NUMBER() OVER (PARTITION BY r.VendorID, dd.tripYear, dd.tripMonth
                           ORDER BY COUNT(*) DESC) AS rn
    FROM taxi_route_details r
    JOIN date_dimension dd ON r.tripID = dd.tripID
    GROUP BY r.VendorID, dd.tripYear, dd.tripMonth, trip_hour
) ranked
WHERE rn = 1;
