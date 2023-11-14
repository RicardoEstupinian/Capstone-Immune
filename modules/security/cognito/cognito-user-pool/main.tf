terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_cognito_user_pool" "cognito_pool" {
  name                = var.user_pool_name
  deletion_protection = var.delete_protection
  mfa_configuration   = var.mfa_configuration
  schema {
    attribute_data_type = "String"
    name                = "givenname"
    mutable             = true
  }
  schema {
    attribute_data_type = "String"
    name                = "surname"
    mutable             = true
  }

  lifecycle {
    ignore_changes = [ schema ]
  }
}

resource "aws_cognito_user_pool_domain" "cognito_user_pool_domain" {
  domain       = var.user_pool_domain_name
  user_pool_id = aws_cognito_user_pool.cognito_pool.id
  depends_on = [ aws_cognito_user_pool.cognito_pool ]
}

resource "aws_cognito_user_group" "cognito_groups" {
  count = length(var.cognito_group_names)
  name         = var.cognito_group_names[count.index].name
  description = var.cognito_group_names[count.index].description
  user_pool_id = aws_cognito_user_pool.cognito_pool.id
}