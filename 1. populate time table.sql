-- to populate time table from taxi_route_details
INSERT INTO date_dimension (
    tripID,
    tripYear,
    tripMonth,
    tripDay
)
SELECT 
    tripID,
    YEAR(STR_TO_DATE(tpep_pickup_datetime, '%c/%e/%Y %l:%i %p')) AS tripYear,
    MONTH(STR_TO_DATE(tpep_pickup_datetime, '%c/%e/%Y %l:%i %p')) AS tripMonth,
    DAY(STR_TO_DATE(tpep_pickup_datetime, '%c/%e/%Y %l:%i %p')) AS tripDay
FROM taxi_schema.taxi_route_details;
