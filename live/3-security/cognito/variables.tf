variable "user_pool_name" {
  description = "AWS Cognito user pool name"
  type        = string
}

variable "delete_protection" {
  description = "AWS Cognito user pool deletion protection"
  type        = string
  default     = "INACTIVE"
}

variable "mfa_configuration" {
  description = "AWS MFA configuration. Valid values: ON | OFF | OPTION"
  type        = string
  default     = "OFF"
}

variable "default_tags" {
  description = "Default tags to use in all AWS resources"
  type        = map(string)
}

variable "user_pool_domain_name" {
  description = "AWS Cognito user pool domain name"
  type        = string
}

variable "cognito_group_names" {
  description = "AWS Cognito groups name"
  type = list(object({
    name        = string
    description = string
  }))
}