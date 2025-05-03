CREATE OR REPLACE EXTERNAL TABLE `nodal-pod-448911-c5.ny_taxi_zoomcamp.fhv_tripdata`
OPTIONS (
  format = 'CSV',
  uris = ['gs://ny_taxi_zoomcamp/fhv_tripdata_2019-*.csv']
);


SELECT count(*) FROM `nodal-pod-448911-c5.ny_taxi_zoomcamp.fhv_tripdata`;

SELECT COUNT(DISTINCT(dispatching_base_num)) FROM `nodal-pod-448911-c5.ny_taxi_zoomcamp.fhv_tripdata`;

CREATE OR REPLACE TABLE `nodal-pod-448911-c5.ny_taxi_zoomcamp.fhv_nonpartitioned_tripdata`
AS SELECT * FROM `nodal-pod-448911-c5.ny_taxi_zoomcamp.fhv_tripdata`;

CREATE OR REPLACE TABLE `nodal-pod-448911-c5.ny_taxi_zoomcamp.fhv_partitioned_tripdata`
PARTITION BY DATE(dropoff_datetime)
CLUSTER BY dispatching_base_num AS (
  SELECT * FROM `nodal-pod-448911-c5.ny_taxi_zoomcamp.fhv_tripdata`
);

SELECT count(*) FROM  `nodal-pod-448911-c5.ny_taxi_zoomcamp.fhv_nonpartitioned_tripdata`
WHERE DATE(dropoff_datetime) BETWEEN '2019-01-01' AND '2019-03-31'
  AND dispatching_base_num IN ('B00987', 'B02279', 'B02060');

SELECT count(*) FROM `nodal-pod-448911-c5.ny_taxi_zoomcamp.fhv_partitioned_tripdata`
WHERE DATE(dropoff_datetime) BETWEEN '2019-01-01' AND '2019-03-31'
  AND dispatching_base_num IN ('B00987', 'B02279', 'B02060');