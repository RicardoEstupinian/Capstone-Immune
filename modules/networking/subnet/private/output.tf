output "sb_arn" {
  value = aws_subnet.private_subnets[*].arn
}

output "sb_id" {
  value = aws_subnet.private_subnets[*].id
}