terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.region
  default_tags {
    tags = var.default_tags
  }
}


resource "aws_security_group" "sg" {
  count = length(var.sg_specification)
  name = "${var.project_name}-${var.sg_specification[count.index].service_name}-sg-${var.environment}"
  vpc_id = var.vpc_id
  tags = {
    Name : "${var.project_name}-${var.sg_specification[count.index].service_name}-sg-${var.environment}"
  }
  dynamic "ingress" {
    for_each = var.sg_specification[count.index].ingress_rules
    content {
      description      = ingress.value.description
      from_port        = ingress.value.from_port
      to_port          = ingress.value.to_port
      protocol         = ingress.value.protocol
      cidr_blocks      = ingress.value.cidr_blocks
      security_groups   = ingress.value.security_groups
    }
  }

  dynamic "egress" {
    for_each = var.sg_specification[count.index].egress_rules
    content {
      description = egress.value.description
      from_port = egress.value.from_port
      to_port = egress.value.to_port
      protocol = egress.value.protocol
      cidr_blocks = egress.value.cidr_blocks
    }
  }
}
