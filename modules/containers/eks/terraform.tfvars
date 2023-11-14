default_tags = {
  author = "ricardo.estupinian"
  project = "consultores-bid"
  environment = "dev"
  managed = "terraform"
  team = "devops"
}
region = "us-east-1"
aws_profile_used = "onec-dev-rbel"
eks_cluster_name = "consultoresbid-eks"
endpoint_public_access = true
endpoint_private_access = true
fargate_profiles = [
  {
    fargateProfileName = "ingress-controller-fgp"
    profileNamespace = "app"
    labels = {
      app = ""
    }
  },
  {
    fargateProfileName = "kube-system-fgp"
    profileNamespace = "kube-system"
    labels = {
      app = ""
    }
  },
  {
    fargateProfileName = "backend-fgp"
    profileNamespace = "app"
    labels = {
      app = "backend"
    }
  }
]

subnets_ids = [
  "subnet-05a892b95604f48b4",
  "subnet-044b55d05e0135984",
  "subnet-07d3d026fc0d4c1d8",
  "subnet-00da4245d884ac790"
]
project_name = "consultoresbid"
vpc_id = "vpc-0687609cd1a6a96d0"
private_subnets = [
"subnet-05a892b95604f48b4",
"subnet-044b55d05e0135984"
]
public_subnets = "subnet-05a892b95604f48b4, subnet-044b55d05e0135984"