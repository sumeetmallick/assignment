resource "google_compute_backend_service" "global_backend" {
  connection_draining_timeout_sec = 0
  enable_cdn                      = true
  load_balancing_scheme           = "EXTERNAL_MANAGED"
  locality_lb_policy              = "ROUND_ROBIN"
  name                            = var.backend_name
  port_name                       = "http"
  protocol                        = "HTTP"
  compression_mode                = "DISABLED"
  
  outlier_detection {
    consecutive_errors = 5
  }
  backend {
    balancing_mode  = "UTILIZATION"
    capacity_scaler = 1
    description     = "Portal Backend"
    group           = google_compute_region_network_endpoint_group.neg.id
  }
  log_config {
    enable      = true
    sample_rate = 1
  }
}

resource "google_compute_region_network_endpoint_group" "neg" {
  name                  = var.neg_name
  network_endpoint_type = "SERVERLESS"
  region                = var.region
   cloud_function{
    function  = var.cf_name
  }
}
resource "google_compute_url_map" "lb" {
  default_service = google_compute_backend_service.global_backend.id
  name            = var.lb_name
}
resource "google_compute_target_http_proxy" "lb_http" {
  name       = var.http_proxy_name
  proxy_bind = false
  url_map    = google_compute_url_map.lb.self_link
}

resource "google_compute_global_forwarding_rule" "fw_rule" {
  ip_protocol           = "TCP"
  load_balancing_scheme = "EXTERNAL_MANAGED"
  name                  = var.fw_rule_name
  port_range            = "80"
  target                = google_compute_target_http_proxy.lb_http.self_link
}

