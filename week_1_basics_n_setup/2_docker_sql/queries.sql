-- How many taxi trips were totally made on September 18th 2019?
select count(*) from green_taxi_data
where 
	lpep_pickup_datetime >= '2019-09-18'
	AND lpep_dropoff_datetime < '2019-09-19';


-- Which was the pick up day with the largest trip distance Use the pick up time for your calculations.
select lpep_pickup_datetime::date from green_taxi_data
where trip_distance = (select max(trip_distance) from green_taxi_data);


-- Which were the 3 pick up Boroughs that had a sum of total_amount superior to 50000?
select q."Borough" AS borough, sum(total_amount) AS amount from (
	select zpu."Borough", total_amount from green_taxi_data t
		JOIN zones zpu 
			ON t."PULocationID" = zpu."LocationID"
	WHERE 
		t.lpep_pickup_datetime::date = '2019-09-18'
) q 
GROUP BY q."Borough"


-- For the passengers picked up in September 2019 in the zone name Astoria which was the drop off zone that had the largest tip?
SELECT 
	max(q.tip) as tip, 
	q.drop_zone as drop
FROM (select 
	t.tip_amount AS tip,
	zdo."Zone" AS drop_zone,
	zpu."Zone" AS pick
	FROM 
		green_taxi_data t LEFT JOIN zones zpu 
			ON t."PULocationID" = zpu."LocationID"
		LEFT JOIN zones zdo
			ON t."DOLocationID" = zdo."LocationID"
	WHERE 
		zpu."Zone" = 'Astoria'
		AND (SELECT EXTRACT('Year' FROM t.lpep_pickup_datetime)) = '2019') q
GROUP BY drop_zone
ORDER BY tip desc
LIMIT 1;