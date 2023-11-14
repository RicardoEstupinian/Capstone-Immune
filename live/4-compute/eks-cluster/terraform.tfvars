default_tags = {
  author      = "Grupo 4"
  project     = "capstone"
  environment = "dev"
  managed     = "terraform"
  team        = "devops"
}
region = "us-east-1"
aws_profile_used = "rbel-profile"
eks_cluster_name = "capstone-eks"
endpoint_public_access = true
endpoint_private_access = true
fargate_profiles = [
  {
    fargateProfileName = "ingress-controller-fgp"
    profileNamespace = "app"
    labels = {}
  },
  {
    fargateProfileName = "kube-system-fgp"
    profileNamespace = "kube-system"
    labels = {}
  },
  {
    fargateProfileName = "app-fgp"
    profileNamespace = "app"
    labels = {
      app = "backend"
    }
  }
]
ingress_controller_namespace = "app"
subnets_ids = [
  "subnet-0078b5f90983db917", #PRIVATE SUBNETS
  "subnet-0b07c7694d4cf2abc"
]
project_name = "capstone"
vpc_id = "vpc-0ce0b35cd8d694981"
private_subnets = [
  "subnet-0078b5f90983db917",
  "subnet-0b07c7694d4cf2abc"
]