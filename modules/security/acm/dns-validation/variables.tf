variable "default_tags" {
  description = "Default tags to use in all AWS resources"
  type        = map(string)
}

variable "region" {
  type        = string
  description = "Master region to deploy"
}

variable "domain_name" {
  type        = string
  description = "New domain name"
}


variable "dns_name" {
  type        = string
  description = "Existing domain name"
}

variable "domain_names" {
  type        = list(string)
  description = "List of domain names to include in the ACM certificate"
}
