terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.region
  default_tags {
    tags = var.default_tags
  }
}

resource "aws_ecr_repository" "ecr_repository" {
  count = length(var.services_names)
  name = "${var.project_name}-${var.services_names[count.index]}-ecr-${var.environment}"
  image_scanning_configuration {
    scan_on_push = true
  }
}
