## NETWORKING
module "vpc_with_subnets" {
  source               = "../../modules/networking/vpc"
  azs                  = var.azs
  default_tags         = var.default_tags
  private_subnet_cidrs = var.private_subents_cidrs
  public_subnet_cidrs  = var.public_subnet_cidrs
  region               = var.region
  vpc_cidr_block       = var.vpc_cidr_block
  vpc_tag_name         = var.vpc_tag_name
}