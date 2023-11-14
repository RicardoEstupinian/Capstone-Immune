output "app_client_id" {
  value = aws_cognito_user_pool_client.app_client.id
}

output "app_client_name" {
  value = aws_cognito_user_pool_client.app_client.name
}