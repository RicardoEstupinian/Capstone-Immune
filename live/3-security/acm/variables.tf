variable "domain_names" {
  type        = list(string)
  description = "New domain name"
}

variable "dns_name" {
  type        = string
  description = "Existing domain name"
}

variable "validation_method" {
  type        = string
  description = "Validation Method EMAIL or DNS"
  default     = "EMAIL"
}

variable "default_tags" {
  description = "Default tags to use in all AWS resources"
  type        = map(string)
}

variable "region" {
  description = "Region AWS"
  type        = string
}
