variable "user_pool_name" {
  description = "AWS Cognito user pool name"
  type        = string
}

variable "delete_protection" {
  description = "AWS Cognito user pool deletion protection"
  type        = string
}

variable "mfa_configuration" {
  description = "AWS MFA configuration. Valid values: ON | OFF | OPTION"
  type        = string
}

variable "user_pool_domain_name" {
  description = "AWS Cognito user pool domain name"
  type = string
}

variable "cognito_group_names" {
  description = "AWS Cognito groups name"
  type = list(object({
    name = string
    description = string
  }))
}