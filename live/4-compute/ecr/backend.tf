terraform {
  backend "s3" {
    bucket         = "capstone-terraform"
    key            = "dev/capstone/compute/ecr.tfstate"
    region         = "us-east-1"
    dynamodb_table = "capstone-terraform-locks-dev"
    encrypt        = true
  }
}
