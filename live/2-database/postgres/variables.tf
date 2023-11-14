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

variable "project_name" {
  description = "Project name"
  type        = string
}

variable "cluster_identifier" {
  description = "Cluster identifier"
  type        = string
}

variable "db_username" {
  description = "The username for the database"
  type        = string
  sensitive   = true
}

variable "db_password" {
  description = "The password for the database"
  type        = string
  sensitive   = true
}

variable "engine" {
  description = "Cluster engine"
  type        = string
}

variable "engine_mode" {
  description = "Engine mode"
  type        = string
}

variable "engine_version" {
  description = "Engine version"
  type        = string
}

variable "database_name" {
  description = "database name"
  type        = string
}

variable "max_capacity" {
  description = "Maximun capacity cluster"
  type        = number
}

variable "min_capacity" {
  description = "Minimun capacity cluster"
  type        = number
}

variable "instance_class" {
  description = "Instance class"
  type        = string
}

variable "subnet_ids" {
  description = "Subnet Ids for cluster"
  type        = list(string)
}

variable "vpc_id" {
  description = "VPC id"
  type        = string
}

variable "sg_specification" {
  description = "A list of security group specification with ingress and egress rules"
  type = list(object({
    service_name = string
    ingress_rules = list(object({
      from_port   = number
      to_port     = number
      protocol    = string
      cidr_blocks = list(string)
      description = string
    }))
    egress_rules = list(object({
      from_port   = number
      to_port     = number
      protocol    = string
      cidr_blocks = list(string)
      description = string
    }))
  }))
}