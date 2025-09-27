-- Count the number of trips per vendor per month per pickup location (NAIVE)
SELECT 
    r.VendorID,
    r.PULocationID,
    dd.tripYear AS trip_year,
    dd.tripMonth AS trip_month,
    COUNT(*) AS trip_count
FROM taxi_route_details r
JOIN date_dimension dd ON r.tripID = dd.tripID
GROUP BY r.VendorID, r.PULocationID, dd.tripYear, dd.tripMonth
ORDER BY dd.tripYear, dd.tripMonth, r.VendorID, r.PULocationID;

-- Count the number of trips per vendor per month per pickup location (OPTIMIZED)
SELECT 
    r.VendorID,
    r.PULocationID,
    CONCAT(dd.tripYear, '-', LPAD(dd.tripMonth, 2, '0')) AS trip_month,
    COUNT(*) AS trip_count
FROM taxi_route_details r
JOIN date_dimension dd ON r.tripID = dd.tripID
GROUP BY r.VendorID, r.PULocationID, dd.tripYear, dd.tripMonth
ORDER BY dd.tripYear, dd.tripMonth, r.VendorID, r.PULocationID;