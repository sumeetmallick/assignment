module "vpc" {
  source        = "./module/vpc"
  vpc_name      = "${var.environment}-${var.prefix}-vpc"
  subnet_name   = "${var.environment}-${var.prefix}-subnet"
  connector     = "${var.environment}-${var.prefix}-connector"
  ip_cidr_range = var.ip_cidr_range
  region        = var.region
}

module "cf" {
  source        = "./module/cf"
  bucket_name   = "${var.environment}-${var.prefix}-bucket"
  location      = var.region
  storage_class = var.storage_class
  entry_point   = var.entry_point
  cf_name       = "${var.environment}-${var.prefix}-cf"
  display_name  = "${var.prefix}-sa"
  output_path   = "${var.environment}-${var.prefix}.zip"
  connector     = "${var.environment}-${var.prefix}-connector"
  member         = var.member  
  depends_on    = [module.vpc]
}

module "lb" {
  source          = "./module/lb"
  lb_ip_name      = "${var.environment}-${var.prefix}-lb-ip"
  backend_name    = "${var.environment}-${var.prefix}-backend"
  neg_name        = "${var.environment}-${var.prefix}-neg"
  cf_name         = "${var.environment}-${var.prefix}-cf"
  lb_name         = "${var.environment}-${var.prefix}-lb"
  http_proxy_name = "${var.environment}-${var.prefix}-http-proxy"
  fw_rule_name    = "${var.environment}-${var.prefix}-forwarding-rule"
  region          = var.region
  depends_on      = [module.vpc, module.cf]
}


