variable "region" {
  description = "Region AWS"
  type        = string
}

variable "default_tags" {
  description = "Default tags to use in all AWS resources"
  type        = map(string)
}

variable "vpc_id" {
  description = "VPC Id"
  type = string
}

variable "environment" {
  description = "Environment name"
}

variable "project_name" {
  description = "Project name used as a suffix in resources created"
}

variable "sg_specification" {
  description = "A list of security group specification with ingress and egress rules"
  type        = list(object({
    service_name  = string
    ingress_rules = list(object({
      from_port   = number
      to_port     = number
      protocol    = string
      cidr_blocks = list(string)
      security_groups = list(string)
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