-- Goal: Find the average tip % per vendor
USE taxi_schema;

SELECT 
			r.VendorID,
			ROUND(AVG((p.tip_amount / p.fare_amount) * 100), 2) AS avg_tip_percent
FROM		taxi_route_details r
JOIN 		taxi_payment_details p 
    ON 		r.tripID = p.tripID
GROUP BY 	r.VendorID
ORDER BY 	avg_tip_percent DESC;
