output "sg_id" {
  value = module.sgs[*].sg_id
}

output "sg_arn" {
  value = module.sgs[*].sg_arn
}

output "sg_name" {
  value = module.sgs[*].sg_name
}