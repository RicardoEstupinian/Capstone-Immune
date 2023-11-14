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

#DNS Configuration
#Get already , publicly configured Hosted Zone on Route53 - MUST EXIST
data "aws_route53_zone" "dns" {
  name     = var.dns_name
}

#ACM CONFIGURATION
#Creates ACM certificate and requests validation via DNS(Route53)
resource "aws_acm_certificate" "certificate" {
  domain_name       = var.domain_names[0]
  validation_method = "DNS"
  subject_alternative_names = var.domain_names

  lifecycle {
    create_before_destroy = true
  }
}

