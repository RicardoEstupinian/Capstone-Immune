output "aws_acm_arn" {
  value       = module.acm.aws_acm_arn
  description = "ARN of the ACM certificate"
}
