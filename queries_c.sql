-- Count the number of trips per vendor per month per pickup location (NAIVE)
SELECT 
    r.VendorID,
    r.PULocationID,
    YEAR(STR_TO_DATE(r.tpep_pickup_datetime, '%Y-%m-%d %H:%i:%s')) AS trip_year,
    MONTH(STR_TO_DATE(r.tpep_pickup_datetime, '%Y-%m-%d %H:%i:%s')) AS trip_month,
    COUNT(*) AS trip_count
FROM taxi_route_details r
GROUP BY r.VendorID, r.PULocationID, trip_year, trip_month
ORDER BY trip_year, trip_month, r.VendorID, r.PULocationID;

-- Count the number of trips per vendor per month per pickup location (OPTIMIZED)
SELECT 
    r.VendorID,
    r.PULocationID,
    DATE_FORMAT(STR_TO_DATE(r.tpep_pickup_datetime, '%Y-%m-%d %H:%i:%s'), '%Y-%m') AS trip_month,
    COUNT(*) AS trip_count
FROM taxi_route_details r
GROUP BY r.VendorID, r.PULocationID, trip_month
ORDER BY trip_month, r.VendorID, r.PULocationID;