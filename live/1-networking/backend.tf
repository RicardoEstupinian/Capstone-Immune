terraform {
  backend "s3" {
    bucket         = "capstone-terraform"
    key            = "dev/capstone/all-project/acm/acm.tfstate"
    region         = "us-east-1"
    dynamodb_table = "capstone-terraform-locks-dev"
    encrypt        = true
  }
}