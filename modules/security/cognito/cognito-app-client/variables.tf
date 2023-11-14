variable "default_tags" {
  description = "Default tags to use in all AWS resources"
  type        = map(string)
}

variable "region" {
  description = "Region AWS"
  type        = string
}

variable "project" {
  description = "Project name"
  type        = string
}

variable "environment" {
  description = "Environment name. Valid values: dev,qa,uat,prod"
  type        = string
}

variable "cognito_user_pool_id" {
  description = "AWS Cognito user pool id"
  type = string
}

variable "auth_flows" {
  description = "List of auth flows. Valid values: ADMIN_NO_SRP_AUTH, CUSTOM_AUTH_FLOW_ONLY, USER_PASSWORD_AUTH, ALLOW_ADMIN_USER_PASSWORD_AUTH, ALLOW_CUSTOM_AUTH, ALLOW_USER_PASSWORD_AUTH, ALLOW_USER_SRP_AUTH, ALLOW_REFRESH_TOKEN_AUTH"
  type = list(string)
}

variable "idp_supported" {
  description = "List of Idp supported. Name of idp configure with aws_cognito_identity_provider resource or: COGNITO"
  type = list(string)
}

variable "callback_urls" {
  description = "List of callback urls to use in frontend app"
  type = list(string)
}

variable "logout_urls" {
  description = "List of log out urls to use in frontend app"
  type = list(string)
}

variable "allowed_oauth_scopes" {
  description = "Allow oauth scopes. Valid values: phone, email, openid, profile, and aws.cognito.signin.user.admin"
  type = list(string)
}

variable "allowed_oauth_flows" {
  description = "Allow oauth flows. Valid values: code, implicit, client_credentials."
  type = list(string)
}