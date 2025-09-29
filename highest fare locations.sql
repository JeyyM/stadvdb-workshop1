-- Goal: Find which locations have the highest average fare amounts
USE taxi_schema;

SELECT 
			z.Zone AS pickup_zone,
			ROUND(AVG(p.fare_amount), 2) AS avg_fare_amount
FROM 		taxi_route_details r
JOIN 		taxi_payment_details p 
    ON 		r.tripID = p.tripID
JOIN		zone_lookup z 
    ON		r.PULocationID = z.location_id
GROUP BY 	z.Zone
ORDER BY 	avg_fare_amount DESC
LIMIT 10;