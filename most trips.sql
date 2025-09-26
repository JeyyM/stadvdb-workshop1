-- Which vendor got the most trips per month?
SELECT trd.VendorID, dd.pickup_month, COUNT(*) AS trip_count
FROM taxi_route_details AS trd
JOIN date_dimension AS dd
  ON trd.tripID = dd.tripID
GROUP BY dd.pickup_month, trd.VendorID
ORDER BY trip_count DESC;
