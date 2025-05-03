### Install Terraform
https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli

### Authenticate to service account
```bash
gcloud auth activate-service-account --key-file=/path/to/your-service-account-key.json
```

### Run Terraform
```bash
terraform init
terraform plan
terraform apply
```

### Install Docker & Docker Compose
https://docs.docker.com/engine/install/ubuntu/
https://docs.docker.com/compose/install/linux/

### Docker without sudo
```bash
getent group docker
sudo groupadd docker            # create group if it doesn't exist
sudo usermod -aG docker $USER   # add your user to the docker group
sudo service docker restart
groups                          # check if your user is in the docker group
exit and login again
```

### Run app in Docker
```bash
docker build -t taxi_ingest:v001 . # build the image

URL="https://github.com/DataTalksClub/nyc-tlc-data/releases/download/yellow/yellow_tripdata_2021-01.csv.gz"

docker run -it \  # run the container
  --network=pg-network \
  taxi_ingest:v001 \
    --user=root \
    --password=root \
    --host=pgdatabase \
    --port=5432 \
    --db=ny_taxi \
    --table_name=yellow_taxi_trips \
    --url=${URL}
```