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

resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = var.vpc_tag_name
  }
}

module "private_subnets" {
  source = "../subnet/private"
  availability_zones = var.azs
  default_tags = var.default_tags
  private_subnet_cidrs = var.private_subnet_cidrs
  region = var.region
  vpc_id = aws_vpc.vpc.id
}

module "public_subnets" {
  source = "../subnet/public"
  availability_zones = var.azs
  default_tags = var.default_tags
  public_subnet_cidrs = var.public_subnet_cidrs
  region = var.region
  vpc_id = aws_vpc.vpc.id
}