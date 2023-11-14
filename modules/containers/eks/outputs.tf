output "eks_cluster_name" {
  value = aws_eks_cluster.kubernetes_cluster.name
  description = "Name of the EKS cluster"
}

output "eks_cluster_arn" {
  value = aws_eks_cluster.kubernetes_cluster.arn
  description = "ARN of the EKS cluster"
}

output "eks_cluster_endpoint" {
  value = aws_eks_cluster.kubernetes_cluster.endpoint
  description = "Endpoint of the EKS cluster"
}

output "eks_cluster_certificate_authority" {
  value = aws_eks_cluster.kubernetes_cluster.certificate_authority
  description = "Certificate authority of the EKS cluster"
}

output "alb_ingress_controller_role_arn" {
  value = aws_iam_role.alb_ingress_controller_role.arn
}