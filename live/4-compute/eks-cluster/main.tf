## EKS CLUSTER
module "eks-cluster" {
  source = "../../../modules/containers/eks"
  aws_profile_used = var.aws_profile_used
  default_tags = var.default_tags
  eks_cluster_name = var.eks_cluster_name
  endpoint_private_access = var.endpoint_private_access
  endpoint_public_access = var.endpoint_public_access
  fargate_profiles = var.fargate_profiles
  ingress_controller_namespace = var.ingress_controller_namespace
  region = var.region
  subnets_ids = var.subnets_ids
  project_name = var.project_name
  vpc_id = var.vpc_id
  private_subnets = var.private_subnets
}