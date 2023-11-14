variable "region" {
  description = "AWS region to create resources"
  type = string
}

variable "default_tags" {
  description = "Default tags to use in all AWS resources"
  type        = map(string)
}

variable "vpc_id" {
  description = "VPC Id"
  type = string
}