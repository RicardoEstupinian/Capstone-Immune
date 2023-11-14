variable "region" {
  description = "AWS region to create resources"
  type = string
}

variable "default_tags" {
  description = "Default tags to use in all AWS resources"
  type        = map(string)
}

variable "services_names" {
  description = "List of services names. Used to build repository name"
  type        = list(string)
}

variable "environment" {
  description = "Environment name"
}

variable "project_name" {
  description = "Project name"
}
