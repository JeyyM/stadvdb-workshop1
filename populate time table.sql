-- to populate time table from taxi_route_details
INSERT INTO date_dimension (
    tripID,
    pickup_year, pickup_month, pickup_day,
    dropoff_year, dropoff_month, dropoff_day
)
SELECT 
    tripID,
    YEAR(STR_TO_DATE(tpep_pickup_datetime, '%c/%e/%Y %l:%i %p')) AS pickup_year,
    MONTH(STR_TO_DATE(tpep_pickup_datetime, '%c/%e/%Y %l:%i %p')) AS pickup_month,
    DAY(STR_TO_DATE(tpep_pickup_datetime, '%c/%e/%Y %l:%i %p')) AS pickup_day,
    YEAR(STR_TO_DATE(tpep_dropoff_datetime, '%c/%e/%Y %l:%i %p')) AS dropoff_year,
    MONTH(STR_TO_DATE(tpep_dropoff_datetime, '%c/%e/%Y %l:%i %p')) AS dropoff_month,
    DAY(STR_TO_DATE(tpep_dropoff_datetime, '%c/%e/%Y %l:%i %p')) AS dropoff_day
FROM taxi_schema.taxi_route_details;
