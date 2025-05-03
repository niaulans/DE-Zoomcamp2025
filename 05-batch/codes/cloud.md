## Running Spark in the Cloud

### Important port in Spark
| Component             | Port Default |
| --------------------  | ------------ |
| Spark Web UI          | 4040         |
| Spark Master UI       | 8080         |
| Spark Worker UI       | 8081, 8082,..|
| Spark Master (RPC)    | 7077         |

### Connecting to Google Cloud Storage 

Uploading data to GCS:
```bash
gsutil -m cp -r ~/projects/zoomcamp_env/DE-Zoomcamp2025/05-batch/datasets/data/pq/ gs://ny_taxi_zoomcamp/pq
```

Download the jar for connecting to GCS to any location
```bash
gsutil cp gs://hadoop-lib/gcs/gcs-connector-hadoop3-2.2.5.jar ./
```

### Local Cluster and Spark-Submit

Creating a stand-alone cluster ([docs](https://spark.apache.org/docs/latest/spark-standalone.html)):

```bash
cd /opt/spark
./sbin/start-master.sh
```

Port to access the master UI: http://localhost:8080

```bash
Creating a worker:

```bash
cd /opt/spark
URL="spark://zoomcamp-new.asia-southeast2-a.c.nodal-pod-448911-c5.internal:7077"
./sbin/start-worker.sh ${URL}

# for newer versions of spark use that:
#./sbin/start-worker.sh ${URL}
```

Turn the notebook into a script:

```bash
jupyter nbconvert --to=script 06_spark_sql.ipynb
```

Edit the script and then run it:

```bash 
python 06_spark_sql.py \
    --input_green=data/pq/green/2020/*/ \
    --input_yellow=data/pq/yellow/2020/*/ \
    --output=data/report-2020
```

Use `spark-submit` for running the script on the cluster

```bash
URL="spark://zoomcamp-new.asia-southeast2-a.c.nodal-pod-448911-c5.internal:7077"

spark-submit \
    --master="${URL}" \
    06_spark_sql.py \
        --input_green=data/pq/green/2021/*/ \
        --input_yellow=data/pq/yellow/2021/*/ \
        --output=data/report-2021
```

### Data Proc

Upload the script to GCS:

```bash
gsutil -m cp -r 06_spark_sql.py gs://ny_taxi_zoomcamp/code/06_spark_sql.py
```

Params for the job:

* `--input_green=gs://ny_taxi_zoomcamp/pq/green/2021/*/`
* `--input_yellow=gs://ny_taxi_zoomcamp/pq/yellow/2021/*/`
* `--output=gs://ny_taxi_zoomcamp/report-2021`


Using Google Cloud SDK for submitting to dataproc
([link](https://cloud.google.com/dataproc/docs/guides/submit-job#dataproc-submit-job-gcloud))

```bash
gcloud dataproc jobs submit pyspark \
    --cluster=de-zoomcamp-cluster \
    --region=europe-west6 \
    gs://ny_taxi_zoomcamp/code/06_spark_sql.py \
    -- \
        --input_green=gs://ny_taxi_zoomcamp/pq/green/2020/*/ \
        --input_yellow=gs://ny_taxi_zoomcamp/pq/yellow/2020/*/ \
        --output=gs://ny_taxi_zoomcamp/report-2020
```

### Big Query

Upload the script to GCS:

```bash
gsutil -m cp -r 06_spark_sql_big_query.py gs://ny_taxi_zoomcamp/code/06_spark_sql_big_query.py
```

Write results to big query ([docs](https://cloud.google.com/dataproc/docs/tutorials/bigquery-connector-spark-example#pyspark)):

```bash
gcloud dataproc jobs submit pyspark \
    --cluster=de-zoomcamp-cluster \
    --region=europe-west6 \
    --jars=gs://spark-lib/bigquery/spark-bigquery-latest_2.12.jar \
    gs://ny_taxi_zoomcamp/code/06_spark_sql_big_query.py \
    -- \
        --input_green=gs://ny_taxi_zoomcamp/pq/green/2020/*/ \
        --input_yellow=gs://ny_taxi_zoomcamp/pq/yellow/2020/*/ \
        --output=trips_data_all.reports-2020
```