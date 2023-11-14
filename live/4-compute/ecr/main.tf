## ECR Repository
module "ecr_repositories" {
  source = "../../../modules/containers/ecr"
  default_tags       = var.default_tags
  region             = var.region
  environment = var.environment
  project_name = var.project_name
  services_names = var.services_names
}