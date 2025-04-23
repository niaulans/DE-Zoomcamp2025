-- Query public available table
SELECT
station_id, name
FROM `bigquery-public-data.new_york_citibike.citibike_stations` 
LIMIT 100;

-- Creating external table refering to gcs path
CREATE OR REPLACE EXTERNAL TABLE `ny_taxi_zoomcamp.yellow_tripdata_external`
OPTIONS (
  format = 'CSV',
  uris = ['gs://ny_taxi_zoomcamp/yellow_tripdata_2019-*', 'gs://ny_taxi_zoomcamp/yellow_tripdata_2020-*']
);

-- Check yellow tripdata external
SELECT * FROM `ny_taxi_zoomcamp.yellow_tripdata_external` 
LIMIT 100;

-- Create a non partitioned table from external table
CREATE OR REPLACE TABLE `ny_taxi_zoomcamp.yellow_tripdata_external_non_partitioned` AS
SELECT * FROM `ny_taxi_zoomcamp.yellow_tripdata_external`;

-- CREATE a partitioned table from external table
CREATE OR REPLACE TABLE `ny_taxi_zoomcamp.yellow_tripdata_external_partitioned` 
PARTITION BY DATE(tpep_pickup_datetime) AS 
SELECT * FROM `ny_taxi_zoomcamp.yellow_tripdata_external`;

-- Impact of partition
-- Query scans 582.21 MB 
SELECT DISTINCT (VendorID)
FROM `ny_taxi_zoomcamp.yellow_tripdata_external_non_partitioned`
WHERE DATE(tpep_pickup_datetime) BETWEEN '2019-01-01' AND '2019-01-31';

-- Query scans 117 MB
SELECT DISTINCT (VendorID)
FROM `ny_taxi_zoomcamp.yellow_tripdata_external_partitioned`
WHERE DATE(tpep_pickup_datetime) BETWEEN '2019-01-01' AND '2019-01-31';

-- Let's look into the partitions
SELECT table_name, partition_id, total_rows
FROM `ny_taxi_zoomcamp.INFORMATION_SCHEMA.PARTITIONS`
WHERE table_name = 'yellow_tripdata_external_partitioned'
ORDER BY total_rows DESC;

-- Creating a partition and cluster table
CREATE OR REPLACE TABLE `ny_taxi_zoomcamp.yellow_tripdata_external_partitioned_clustered`
PARTITION BY DATE(tpep_pickup_datetime)
CLUSTER BY VendorID AS
SELECT * FROM `ny_taxi_zoomcamp.yellow_tripdata_external`;

-- Query scans 117 MB
SELECT COUNT(*) as trips
FROM `ny_taxi_zoomcamp.yellow_tripdata_external_partitioned`
WHERE DATE(tpep_pickup_datetime) BETWEEN '2019-01-01' AND '2019-01-31'
  AND VendorID=1;

-- Query scans 117 MB
SELECT COUNT(*) as trips
FROM `ny_taxi_zoomcamp.yellow_tripdata_external_partitioned_clustered`
WHERE DATE(tpep_pickup_datetime) BETWEEN '2019-01-01' AND '2019-01-31'
  AND VendorID=1;
