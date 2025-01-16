output "vpc_name" {
  value       = module.vpc.vpc_name
  description = "Name of the VPC"
}

output "connector_name" {
  value       = module.vpc.connector_name
  description = "Name of the VPC connector"
}

output "cf_name" {
  value       = module.cf.cf_name
  description = "Name of the Cloud Function"
}

output "bucket_name" {
  value       = module.cf.bucket_name
  description = "Name of the storage bucket"
}

output "lb_ip_address" {
  value       = module.lb.lb_ip_address
  description = "External IP address of the Load Balancer"
}

output "lb_name" {
  value       = module.lb.lb_name
  description = "Name of the Load Balancer"
}