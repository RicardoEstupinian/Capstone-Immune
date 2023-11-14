variable "region" {
  description = "AWS region to create resources"
  type = string
}

variable "default_tags" {
  description = "Default tags to use in all AWS resources"
  type        = map(string)
}

variable "vpc_cidr_block" {
  description = "VPC CIDR block"
  type = string
}

variable "vpc_tag_name" {
  description = "VPC tag name"
  type = string
}

variable "public_subnet_cidrs" {
  type        = list(string)
  description = "Public Subnet CIDR values"
}

variable "private_subnet_cidrs" {
  type        = list(string)
  description = "Private Subnet CIDR values"

}

variable "azs" {
  type        = list(string)
  description = "Availability Zones"
}
