output "cf_name" {
  value       = google_cloudfunctions_function.cf.name
  description = "Name of the Cloud Function"
}

output "bucket_name" {
  value       = google_storage_bucket.bucket.name
  description = "Name of the storage bucket"
}