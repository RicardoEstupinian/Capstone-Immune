output "vpc_id" {
  value = module.vpc_with_subnets.vpc_id
}

output "public_subnets_id" {
  value = module.vpc_with_subnets.sb_public_ids
}

output "private_subnets_id" {
  value = module.vpc_with_subnets.vpc_id
}