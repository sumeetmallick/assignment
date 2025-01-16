output "lb_ip_address" {
  value       = google_compute_global_forwarding_rule.fw_rule.ip_address
  description = "External IP address of the Load Balancer"
}

output "lb_name" {
  value       = google_compute_url_map.lb.name
  description = "Name of the Load Balancer"
}