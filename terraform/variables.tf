variable "region" {
  description = "loaction of the bucket"
  type        = string
}

variable "storage_class" {
  description = "storage class of the bucket"
  type        = string
  default     = "STANDARD"
}

variable "uniform_bucket_level_access" {
  description = "uniform bucket level access"
  type        = bool
  default     = true
}

variable "entry_point" {
  description = "uniform bucket level access"
  type        = string
}

variable "project" {
  description = "project name"
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

