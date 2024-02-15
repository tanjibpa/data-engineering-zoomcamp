CREATE OR REPLACE EXTERNAL TABLE `civic-indexer-411316.nyc_green_taxi.green_taxi_data` (
    VendorID INTEGER,
    lpep_pickup_datetime TIMESTAMP,
    lpep_dropoff_datetime TIMESTAMP,
    store_and_fwd_flag STRING,	
    RatecodeID FLOAT64,
    PULocationID INTEGER,
    DOLocationID INTEGER,
    passenger_count FLOAT64,
    trip_distance FLOAT64,
    fare_amount FLOAT64,
    extra FLOAT64,
    mta_tax	FLOAT64,	
    tip_amount FLOAT64,
    tolls_amount FLOAT64,
    ehail_fee INTEGER,
    improvement_surcharge FLOAT64,
    total_amount FLOAT64,
    payment_type FLOAT64,
    trip_type FLOAT64,
    congestion_surcharge FLOAT64,
    lpep_pickup_date DATE
)
OPTIONS (
  format = 'PARQUET',
  uris = ['gs://mage-zoomcamp-ikram/nyc_green_taxi_data/*.parquet']
);


-- creating the external table
CREATE OR REPLACE EXTERNAL TABLE `civic-indexer-411316.nyc_green_taxi.green_taxi_data`
OPTIONS (
  format = 'PARQUET',
  uris = ['gs://mage-zoomcamp-ikram/nyc_green_taxi_data/*.parquet']
);

-- creating the non partitioned table
CREATE OR REPLACE TABLE `civic-indexer-411316.nyc_green_taxi.green_taxi_data_non_partitioned` AS
SELECT * FROM `civic-indexer-411316.nyc_green_taxi.green_taxi_data`;

-- creating the partitioned table
CREATE OR REPLACE TABLE `civic-indexer-411316.nyc_green_taxi.green_taxi_data_partitioned`
PARTITION BY DATE(lpep_pickup_datetime) AS
SELECT * FROM `civic-indexer-411316.nyc_green_taxi.green_taxi_data`;

-- checking the partitioned table
select table_name, partition_id, total_rows
from `nyc_green_taxi.INFORMATION_SCHEMA.PARTITIONS`
where table_name='green_taxi_data_partitioned'
order by total_rows desc;

-- count of the fare_amount=0
select count(*) from `civic-indexer-411316.nyc_green_taxi.green_taxi_data` where fare_amount=0;

-- distinct PULocationID
select distinct(PULocationID) from `civic-indexer-411316.nyc_green_taxi.green_taxi_data`;

-- distinct PULocationID from non partitioned table
select distinct(PULocationID) from `civic-indexer-411316.nyc_green_taxi.green_taxi_data_non_partitioned`;

-- distinct PULocationID from partitioned table in range
select distinct(PULocationID) from `civic-indexer-411316.nyc_green_taxi.green_taxi_data_partitioned`
where lpep_pickup_datetime between '2022-06-01' and '2022-06-30';

-- distinct PULocationID from non partitioned table in range
select distinct(PULocationID) from `civic-indexer-411316.nyc_green_taxi.green_taxi_data_non_partitioned` 
where lpep_pickup_datetime between '2022-06-01' and '2022-06-30';