output "repository_ids" {
  description = "IDs of the created ECR repositories"
  value = aws_ecr_repository.ecr_repository[*].id
}