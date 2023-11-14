# COGNITO POOL
module "cognito_user_pool" {
  source                = "../../../modules/security/cognito/cognito-user-pool"
  user_pool_name        = var.user_pool_name
  delete_protection     = var.delete_protection
  mfa_configuration     = var.mfa_configuration
  user_pool_domain_name = var.user_pool_domain_name
  cognito_group_names   = var.cognito_group_names
}
