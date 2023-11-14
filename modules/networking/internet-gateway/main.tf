terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region  = var.region
  default_tags {
    tags = var.default_tags
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = data.aws_vpc.vpc.id
  tags = {
    Name = "IGW - ${data.aws_vpc.vpc.tags["Name"]}"
  }
}