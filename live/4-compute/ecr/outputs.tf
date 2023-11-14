output "repository_ids" {
  description = "IDs of the created ECR repositories"
  value = module.ecr_repositories.repository_ids[*]
}