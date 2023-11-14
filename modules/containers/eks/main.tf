terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }

    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "~> 2.0"
    }
  }
}

resource "aws_iam_policy" "fluent_logging_custom_policy" {
  name = "${var.eks_cluster_name}-fluentlogging-custom-policy"
  policy = data.aws_iam_policy_document.eks_fargate_fluent_logging_policy.json
}

resource "aws_iam_role" "eks_cluster_service_role" {
  name = "${var.eks_cluster_name}-eksCluster-role"
  assume_role_policy = data.aws_iam_policy_document.eks_controller_assume_role_policy.json
}

resource "aws_iam_role" "eks_fargate_profile_service_role" {
  name = "${var.eks_cluster_name}-eksFargateProfile-role"
  assume_role_policy = data.aws_iam_policy_document.eks_node_assume_role_policy.json
}

resource "aws_iam_role_policy_attachment" "eks_attach_policy_role" {
  policy_arn = data.aws_iam_policy.eks_cluster_policy.arn
  role       = aws_iam_role.eks_cluster_service_role.name
}

resource "aws_iam_role_policy_attachment" "eks_attach_policy_fargate_profile_role" {
  policy_arn = data.aws_iam_policy.eks_pod_execution_policy.arn
  role       = aws_iam_role.eks_fargate_profile_service_role.name
}

resource "aws_iam_role_policy_attachment" "eks_attach_policy_fargate_profile_logging_role" {
  role       = aws_iam_role.eks_fargate_profile_service_role.name
  policy_arn = aws_iam_policy.fluent_logging_custom_policy.arn
}

resource "aws_eks_cluster" "kubernetes_cluster" {
  name     = var.eks_cluster_name
  role_arn = aws_iam_role.eks_cluster_service_role.arn

  vpc_config {
    subnet_ids = var.subnets_ids
    endpoint_public_access = var.endpoint_public_access
    endpoint_private_access = var.endpoint_private_access
  }
}

resource "aws_eks_fargate_profile" "kubernetes_profile" {
  count = length(var.fargate_profiles)
  cluster_name           = aws_eks_cluster.kubernetes_cluster.name
  fargate_profile_name   = var.fargate_profiles[count.index].fargateProfileName
  pod_execution_role_arn = aws_iam_role.eks_fargate_profile_service_role.arn
  subnet_ids = var.private_subnets

  selector {
    namespace = var.fargate_profiles[count.index].profileNamespace
    labels = var.fargate_profiles[count.index].labels
  }
}

# Configure INGRESS CONTROLLER IN AWS
resource "aws_iam_openid_connect_provider" "eks_cluster_oidc_config" {
  client_id_list  = [ "sts.amazonaws.com" ]
  thumbprint_list = [ data.tls_certificate.eks_tls.certificates[0].sha1_fingerprint ]
  url             = aws_eks_cluster.kubernetes_cluster.identity[0].oidc[0].issuer
}

resource "aws_iam_role" "alb_ingress_controller_role" {
  assume_role_policy = data.aws_iam_policy_document.aws_load_balancer_assume_role_policy.json
  name = "${var.project_name}-albingress-role"
}

resource "aws_iam_policy" "alb_ingress_controller_custom_policy" {
  name = "${var.project_name}-albingress-custom-policy"
  policy = file("./AWSLoadBalancerController.json")
}

resource "aws_iam_role_policy_attachment" "alb_ingress_controller_attach_policy" {
  policy_arn = aws_iam_policy.alb_ingress_controller_custom_policy.arn
  role       = aws_iam_role.alb_ingress_controller_role.name
}

## INTALL AWS CONTROLLER HELM
provider "helm" {
  kubernetes {
    host = aws_eks_cluster.kubernetes_cluster.endpoint
    cluster_ca_certificate = base64decode(aws_eks_cluster.kubernetes_cluster.certificate_authority[0].data)
    token = data.aws_eks_cluster_auth.eks_auth.token
    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      args        = ["eks", "get-token", "--cluster-name", aws_eks_cluster.kubernetes_cluster.name, "--region", var.region, "--output", "json"]
      command     = "aws"
      env = {
        name = "AWS_PROFILE"
        value = var.aws_profile_used
      }
    }
  }
}

resource "helm_release" "aws_load_balancer_controller" {
  name  = "aws-load-balancer-controller"
  repository = "https://aws.github.io/eks-charts"
  chart = "aws-load-balancer-controller"
  namespace = "kube-system"

  set {
    name  = "clusterName"
    value = aws_eks_cluster.kubernetes_cluster.id
  }

  set {
    name  = "serviceAccount.name"
    value = "aws-load-balancer-controller"
  }

  set {
    name  = "rbac.create"
    value = "true"
  }

  set {
    name  = "serviceAccount.create"
    value = "true"
  }

  set {
    name  = "enableServiceMutatorWebhook"
    value = "false"
  }

  set {
    name  = "vpcId"
    value = var.vpc_id
  }

  set {
    name  = "region"
    value = var.region
  }

  set {
    name  = "serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
    value = aws_iam_role.alb_ingress_controller_role.arn
  }

  depends_on = [aws_eks_cluster.kubernetes_cluster ,aws_iam_role_policy_attachment.alb_ingress_controller_attach_policy, aws_eks_fargate_profile.kubernetes_profile]
}

## KUBERNETES CONFIG
provider "kubernetes" {
  host = aws_eks_cluster.kubernetes_cluster.endpoint
  cluster_ca_certificate = base64decode(aws_eks_cluster.kubernetes_cluster.certificate_authority[0].data)
  token = data.aws_eks_cluster_auth.eks_auth.token
  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    args        = ["eks", "get-token", "--cluster-name", aws_eks_cluster.kubernetes_cluster.name, "--region", var.region, "--output", "json"]
    command     = "aws"
    env = {
      name = "AWS_PROFILE"
      value = var.aws_profile_used
    }
  }
}

resource "kubernetes_namespace_v1" "ingress_namespace" {
  metadata {
    name = var.ingress_controller_namespace
  }
}

resource "null_resource" "kubectl" {
  provisioner "local-exec" {
    command = "aws eks update-kubeconfig --name ${var.eks_cluster_name} --profile ${var.aws_profile_used}"
  }
  depends_on = [ aws_eks_cluster.kubernetes_cluster ]
}

resource "null_resource" "kube_config" {
  provisioner "local-exec" {
    command = "aws eks update-kubeconfig --name ${var.eks_cluster_name} --profile ${var.aws_profile_used}"
  }
  depends_on = [ aws_eks_cluster.kubernetes_cluster ]
}

#resource "null_resource" "kubectl_patch_coredns" {
#  provisioner "local-exec" {
#    command = "kubectl patch deployment coredns -n kube-system --type json -p='[{\"op\": \"remove\", \"path\":\"/spec/template/metadata/annotations/eks.amazonaws.com~1compute-type\"}]'"
#    interpreter = ["PowerShell", "-Command"]
#  }
#  depends_on = [ aws_eks_cluster.kubernetes_cluster, null_resource.kube_config ]
#}
#
#resource "null_resource" "kubectl_restart_coredns" {
#  provisioner "local-exec" {
#    command = "kubectl rollout restart -n kube-system deployment coredns"
#  }
#  depends_on = [ aws_eks_cluster.kubernetes_cluster, null_resource.kube_config, null_resource.kubectl_patch_coredns ]
#}