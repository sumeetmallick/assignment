variable "region" {
  type        = string
}

variable "storage_class" {
  type        = string
  default     = "STANDARD"
}

variable "uniform_bucket_level_access" {
  type        = bool
  default     = true
}

variable "entry_point" {
  type        = string
}

variable "project" {
  type        = string
}

variable "prefix" {
  type = string
}

variable "environment" {
  type = string
}

variable "ip_cidr_range" {
  type = string
}

variable "member" {
  type        = string
}

