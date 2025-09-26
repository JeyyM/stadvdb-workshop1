USE taxi_schema;

select *,
	YEAR(STR_TO_DATE(tpep_pickup_datetime, '%c/%e/%Y %l:%i %p')) AS year_val,
    MONTH(STR_TO_DATE(tpep_pickup_datetime, '%c/%e/%Y %l:%i %p')) AS month_val,
    DAY(STR_TO_DATE(tpep_pickup_datetime, '%c/%e/%Y %l:%i %p')) AS day_val
from taxi_route_details