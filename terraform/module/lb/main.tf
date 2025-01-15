#resource "google_compute_global_address" "ip_address" {
#  address_type = "EXTERNAL"
#  ip_version   = "IPV4"
#  name         = "var.lb_ip_name"
#}

resource "google_compute_backend_service" "global_backend" {
  connection_draining_timeout_sec = 0
  enable_cdn                      = true
  load_balancing_scheme           = "EXTERNAL_MANAGED"
  locality_lb_policy              = "ROUND_ROBIN"
  name                            = var.backend_name
  port_name                       = "http"
  protocol                        = "HTTP"
  compression_mode                = "DISABLED"
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

# resource "google_compute_managed_ssl_certificate" "ssl_cert" {
#   name        = "${var.environment}-${var.prefix}-ssl"
#   type        = "MANAGED"
#   managed {
#     domains = var.domain
#   }
# }

resource "google_compute_url_map" "lb" {
  default_service = google_compute_backend_service.global_backend.id
  name            = var.lb_name
}

#resource "google_compute_target_https_proxy" "https_proxy" {
#  name             = var.http_proxy_name
# ssl_certificates = [google_compute_managed_ssl_certificate.ssl_cert.id]
#  url_map          = google_compute_url_map.lb.id
#  ssl_policy       = google_compute_ssl_policy.idp-ssl-policy.id
#}

#resource "google_compute_global_forwarding_rule" "fw_rule" {
#  ip_address            = google_compute_global_address.ip_address.address
#  ip_protocol           = "TCP"
#  load_balancing_scheme = "EXTERNAL_MANAGED"
#  name                  = var.fw_rule_name
#  port_range            = "443-443"
#  target                = google_compute_url_map.lb.self_link
#}


#resource "google_compute_url_map" "redirect_lb" {
#  description = "Automatically generated HTTP to HTTPS redirect for the forwarding rule"
#  name        = "${var.environment}-${var.prefix}-redirect"
#  default_url_redirect {
#    https_redirect         = true
#    redirect_response_code = "MOVED_PERMANENTLY_DEFAULT"
#    strip_query            = false
#  }
#}

resource "google_compute_target_http_proxy" "lb_http" {
  name       = var.http_proxy_name
  proxy_bind = false
  url_map    = google_compute_url_map.lb.self_link
}

resource "google_compute_global_forwarding_rule" "fw_rule" {
#  ip_address            = google_compute_global_address.ip_address.address
  ip_protocol           = "TCP"
  load_balancing_scheme = "EXTERNAL_MANAGED"
  name                  = var.fw_rule_name
  port_range            = "80"
  target                = google_compute_target_http_proxy.lb_http.self_link
}

#resource "google_compute_ssl_policy" "idp-ssl-policy" {
#  name            = "${var.environment}-${var.prefix}-lb-ssl-policy"
#  min_tls_version = "TLS_1_2"
#  profile         = "RESTRICTED"
#}
