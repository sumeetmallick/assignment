
resource "google_compute_network" "vpc" {
  name                    = var.vpc_name
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnet" {
  name          = var.subnet_name
  ip_cidr_range = var.ip_cidr_range
  region        = var.region
  network       = google_compute_network.vpc.id
  log_config {
    flow_sampling = 1
  }
}

resource "google_vpc_access_connector" "connector" {
  name          = var.connector
  ip_cidr_range = "10.1.0.0/28"
  network       = google_compute_network.vpc.name
  machine_type  = "f1-micro"
  min_instances = 2
  max_instances = 3
}