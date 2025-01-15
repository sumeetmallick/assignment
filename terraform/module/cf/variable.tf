variable "bucket_name" {
  description = "name of the bucket"
  type        = string
}

variable "location" {
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

variable "cf_name" {
  description = "cloud function name"
  type        = string
}

variable "account_id" {
  description = "account-id for SA"
  type        = string
  default = "test123"
}

variable "display_name" {
  description = "display name of the SA"
  type        = string
}

variable "output_path" {
  type        = string
}

variable "connector" {
  type        = string
}

variable "region" {
  type = string
}

variable "member" {
  type        = string
}
