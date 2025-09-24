-- Count the number of trips per vendor per month per pickup location?
SELECT *
FROM taxi_route_details AS trd
JOIN taxi_payment_details AS tpd
  ON trd.tripID = tpd.tripID
JOIN date_dimension AS dd
  ON trd.tripID = dd.tripID
JOIN date_dimension AS dd
  ON trd.tripID = dd.tripID
  
  
GROUP BY trd.passenger_count
ORDER BY average_earning DESC;
