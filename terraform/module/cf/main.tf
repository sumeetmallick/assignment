#creation of service account for cloud function
resource "google_service_account" "service_account" {
  account_id   = var.account_id
  display_name = "var.display_name"
}
#Cloud function creation
resource "google_cloudfunctions_function" "cf" {
  name        = var.cf_name
  description = "My function"
  runtime     = "python311"

  available_memory_mb           = 128
  source_archive_bucket         = google_storage_bucket.bucket.name
  source_archive_object         = google_storage_bucket_object.upload.name
  trigger_http                  = true
  entry_point                   = var.entry_point
  timeout                       = 540
  vpc_connector                 = var.connector
  vpc_connector_egress_settings = "ALL_TRAFFIC"
  ingress_settings              = "ALLOW_INTERNAL_AND_GCLB"
  service_account_email         = google_service_account.service_account.email
  min_instances                 = 1  
  max_instances                 = 10  
}
# IAM entry for all users to invoke the function
resource "google_cloudfunctions_function_iam_member" "allow_public_access" {
  region         = var.region
  cloud_function = var.cf_name
  role           = "roles/cloudfunctions.invoker"
  member         = var.member
}

#creation of storage bucket 
resource "google_storage_bucket" "bucket" {
  name                        = var.bucket_name
  location                    = var.location
  storage_class               = var.storage_class
  uniform_bucket_level_access = var.uniform_bucket_level_access
}

# create archive 
data "archive_file" "cf_code" {
  type        = "zip"
  source_dir  = "${path.root}/scripts"
  output_path = "${path.module}/${var.output_path}"
}

# upload code to gcs bucket
resource "google_storage_bucket_object" "upload" {
  name   = var.output_path
  bucket = google_storage_bucket.bucket.name
  source = data.archive_file.cf_code.output_path

}