-- Are taxis earning more if they have more passengers?
SELECT passenger_count, AVG(total_amount) as average_earning
FROM taxi_route_details AS trd
JOIN taxi_payment_details AS tpd
  ON trd.tripID = tpd.tripID
GROUP BY trd.passenger_count
ORDER BY average_earning DESC;
