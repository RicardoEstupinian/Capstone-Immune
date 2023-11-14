output "cognito_pool_id" {
  value = module.cognito_user_pool.cognito_user_pool_id
}

output "cognito_pool_domain_name" {
  value = module.cognito_user_pool.cognito_user_pool_domain_name
}