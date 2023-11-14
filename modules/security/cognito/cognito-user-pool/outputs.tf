output "cognito_user_pool_id" {
  value = aws_cognito_user_pool.cognito_pool.id
}

output "cognito_user_pool_domain_name" {
  value = aws_cognito_user_pool_domain.cognito_user_pool_domain.id
}