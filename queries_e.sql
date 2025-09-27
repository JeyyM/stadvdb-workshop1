-- What is the top mode of payment per pickup location? (NAIVE)
SELECT 
    r.PULocationID,
    p.payment_type,
    COUNT(*) AS payment_count
FROM taxi_route_details r
JOIN taxi_payment_details p ON r.tripID = p.tripID
GROUP BY r.PULocationID, p.payment_type
ORDER BY r.PULocationID, payment_count DESC;

-- What is the top mode of payment per pickup location? (OPTIMIZED)
SELECT PULocationID, payment_type, payment_count
FROM (
    SELECT 
        r.PULocationID,
        p.payment_type,
        COUNT(*) AS payment_count,
        ROW_NUMBER() OVER (PARTITION BY r.PULocationID ORDER BY COUNT(*) DESC) AS rn
    FROM taxi_route_details r
    JOIN taxi_payment_details p ON r.tripID = p.tripID
    GROUP BY r.PULocationID, p.payment_type
) ranked
WHERE rn = 1;