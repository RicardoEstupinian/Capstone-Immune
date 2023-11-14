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

resource "aws_cognito_user_pool_client" "app_client" {
  name         = "${var.project}-client-${var.environment}"
  user_pool_id = var.cognito_user_pool_id
  callback_urls = var.callback_urls
  logout_urls = var.logout_urls
  allowed_oauth_scopes = var.allowed_oauth_scopes
  allowed_oauth_flows = var.allowed_oauth_flows
  supported_identity_providers = var.idp_supported
  explicit_auth_flows = var.auth_flows
}