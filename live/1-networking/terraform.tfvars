default_tags = {
  author      = "Grupo 4"
  project     = "capstone"
  environment = "dev"
  managed     = "terraform"
  team        = "devops"
}
region      = "us-east-1"
environment = "dev"

#VPC
azs                   = ["us-east-1a", "us-east-1b"]
vpc_cidr_block        = "192.168.0.0/16"
private_subents_cidrs = ["192.168.0.0/21", "192.168.8.0/21"]
public_subnet_cidrs   = ["192.168.16.0/21", "192.168.24.0/21"]
vpc_tag_name          = "Capstone VPC"