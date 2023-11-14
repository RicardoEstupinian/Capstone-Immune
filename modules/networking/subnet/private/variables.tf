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

variable "private_subnet_cidrs" {
  description = "List of cidrs blocks to create private subnet"
  type = list(string)
}

variable "availability_zones" {
  description = "List of availability zone per subnet"
  type = list(string)
}