output "aws_acm_arn" {
  value       = aws_acm_certificate.certificate.arn
  description = "ARN of the ACM certificate"
}
