## SECURITY GROUPS PER PODS
module "sgs" {
  source           = "../../../modules/security/security-group"
  default_tags     = var.default_tags
  environment      = var.environment
  project_name     = var.project_name
  region           = var.region
  sg_specification = var.sg_specification
  vpc_id           = var.vpc_id
}