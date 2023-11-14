default_tags = {
  author      = "Grupo 4"
  project     = "capstone"
  environment = "dev"
  managed     = "terraform"
  team        = "devops"
}
user_pool_name        = "capstone-pool-dev"
user_pool_domain_name = "capstone-pool-dev"
cognito_group_names   = [
  {
    name = "ADMINISTRADOR_GENERAL"
    description = "Rol para el administrador general del sistema"
  },
]