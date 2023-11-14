variable "eks_cluster_name" {
  description = "EKS Cluster Name"
  type        = string
}

variable "region" {
  description = "Region AWS"
  type        = string
}

variable "default_tags" {
  description = "Default tags to use in all AWS resources"
  type        = map(string)
}

variable "subnets_ids" {
  description = "Subnets Ids to use in cluster EKS creation"
  type        = list(string)
}

variable "endpoint_public_access" {
  description = "Define public access to cluster"
  type = bool
}

variable "endpoint_private_access" {
  description = "Define private access to cluster"
  type = bool
}

variable "fargate_profiles" {
  description = "List of fargate profile name and namespace"
  type = list(object({
    fargateProfileName : string
    profileNamespace : string
    labels : map(string)
  }))
}

variable "aws_profile_used" {
  description = "AWS Profile used to create cluster. This is used to update .kube-config file"
  type = string
}

variable "ingress_controller_namespace" {
  description = "Kubernetes ingress controller namespace"
  type = string
}

variable "project_name" {
  description = "Project name"
  type = string
}

variable "vpc_id" {
  description = "Vpc Id"
  type = string
}

variable "private_subnets" {
  description = "Private subnets to use in fargate profile"
  type = list(string)
}