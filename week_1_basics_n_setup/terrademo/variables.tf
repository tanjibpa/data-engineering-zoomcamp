variable "project" {
  description = "Project ID"
  default     = "civic-indexer-411316"
}

variable "region" {
  description = "Region name"
  default     = "northamerica-northeast2-a"
}

variable "location" {
  description = "Project location"
  default     = "northamerica-northeast2"
}

variable "bq_dataset_name" {
  description = "My BigQuery dataset name"
  default     = "demo_dataset"
}

variable "gcs_bucket_name" {
  description = "GCS bucket name"
  default     = "civic-indexer-411316-terra-bucket"
}

variable "gcs_storage_class" {
  description = "value of storage class"
  default     = "STANDARD"
}

variable "credentials" {
  description = "My Credentials"
  default     = "./keys/my-creds.json"
  #ex: if you have a directory where this file is called keys with your service account json file
  #saved there as my-creds.json you could use default = "./keys/my-creds.json"
}

