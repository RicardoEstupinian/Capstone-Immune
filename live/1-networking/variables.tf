variable "default_tags" {
  description = "Default tags to use in all AWS resources"
  type        = map(string)
}

variable "region" {
  description = "Region AWS"
  type        = string
}

variable "environment" {
  description = "Environment dev, qa, uat, prod"
  type        = string
}

# VPC
variable "azs" {
  description = "Availability Zones"
  type        = list(string)
}

variable "private_subents_cidrs" {
  description = "Private subnets cidr block"
  type        = list(string)
}

variable "public_subnet_cidrs" {
  description = "Public subnets cidr block"
  type        = list(string)
}

variable "vpc_cidr_block" {
  description = "VPC Cidr block"
  type        = string
}

variable "vpc_tag_name" {
  description = "VPC tag name"
  type        = string
}