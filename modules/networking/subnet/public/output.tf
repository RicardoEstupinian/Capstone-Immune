output "sb_arn" {
  value = aws_subnet.public_subnets[*].arn
}

output "sb_id" {
  value = aws_subnet.public_subnets[*].id
}