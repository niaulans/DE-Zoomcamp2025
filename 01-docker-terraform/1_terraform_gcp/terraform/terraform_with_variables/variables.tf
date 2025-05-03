variable "credentials" {
  description = "My GCP Credentials"
  default     = "../../../../creds/service-key.json"
}

variable "project" {
  description = "Project"
  default     = "nodal-pod-448911-c5"
}

variable "region" {
  description = "Region"
  default     = "asia-southeast1"
}

variable "location" {
  description = "Project Location"
  default     = "ASIA-SOUTHEAST1"
}

variable "bq_dataset_name" {
  description = "My BigQuery Dataset Name"
  default     = "demo_dataset"
}

variable "gcs_bucket_name" {
  description = "My Storage Bucket Name"
  default     = "nodal-pod-448911-c5-terra-bucket"
}

variable "gcs_storage_class" {
  description = "Bucket Storage Class"
  default     = "STANDARD"
}

