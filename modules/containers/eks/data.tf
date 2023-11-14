data "aws_iam_policy" "eks_cluster_policy" {
  arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

data "aws_iam_policy" "eks_pod_execution_policy" {
  arn = "arn:aws:iam::aws:policy/AmazonEKSFargatePodExecutionRolePolicy"
}

data "aws_iam_policy_document" "eks_fargate_fluent_logging_policy"{
  statement {
    effect = "Allow"
    actions = [
      "logs:CreateLogStream",
      "logs:CreateLogGroup",
      "logs:DescribeLogStreams",
      "logs:PutLogEvents"
    ]
    resources = ["*"]
  }
}

data "aws_eks_cluster_auth" "eks_auth" {
  name = aws_eks_cluster.kubernetes_cluster.id
  depends_on = [aws_eks_cluster.kubernetes_cluster]
}

data "aws_iam_policy_document" "eks_controller_assume_role_policy" {
  statement {

    effect = "Allow"
    actions = [ "sts:AssumeRole" ]

    principals {
      type = "Service"
      identifiers = [ "eks.amazonaws.com" ]
    }
  }
}

data "aws_iam_policy_document" "eks_node_assume_role_policy" {
  statement {
    effect = "Allow"
    actions = [ "sts:AssumeRole" ]

    principals {
      type = "Service"
      identifiers = [ "eks-fargate-pods.amazonaws.com" ]
    }
  }
}

# Configure INGRESS CONTROLLER IN AWS
data "tls_certificate" "eks_tls" {
  url = aws_eks_cluster.kubernetes_cluster.identity[0].oidc[0].issuer
}
data "aws_iam_policy_document" "aws_load_balancer_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect = "Allow"

    condition {
      test     = "StringEquals"
      values   = ["system:serviceaccount:kube-system:aws-load-balancer-controller"]
      variable = "${replace(aws_iam_openid_connect_provider.eks_cluster_oidc_config.url, "https://", "")}:sub"
    }

    condition {
      test     = "StringEquals"
      values   = ["sts.amazonaws.com"]
      variable = "${replace(aws_iam_openid_connect_provider.eks_cluster_oidc_config.url, "https://", "")}:aud"
    }

    principals {
      identifiers = [ aws_iam_openid_connect_provider.eks_cluster_oidc_config.arn ]
      type        = "Federated"
    }
  }
}
