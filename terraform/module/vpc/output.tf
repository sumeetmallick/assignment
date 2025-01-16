output "vpc_name" {
  value       = google_compute_network.vpc.name
  description = "Name of the VPC"
}

output "connector_name" {
  value       = google_vpc_access_connector.connector.name
  description = "Name of the VPC connector"
}