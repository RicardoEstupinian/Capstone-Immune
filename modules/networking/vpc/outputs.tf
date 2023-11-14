output "sb_private_ids" {
  value = module.private_subnets.sb_id
}

output "sb_public_ids" {
  value = module.public_subnets.sb_id
}

output "vpc_id" {
  value = aws_vpc.vpc.id
}