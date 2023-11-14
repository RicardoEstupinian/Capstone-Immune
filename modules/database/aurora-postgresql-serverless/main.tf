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

resource "aws_rds_cluster" "rds_cluster" {
  cluster_identifier = var.cluster_identifier
  engine             = var.engine
  engine_mode        = var.engine_mode
  engine_version     = var.engine_version
  database_name      = var.database_name
  master_username    = var.db_username
  master_password    = var.db_password
  vpc_security_group_ids = aws_security_group.rds_security_group[*].id
  db_subnet_group_name = aws_db_subnet_group.db_subnet_group.name

  serverlessv2_scaling_configuration {
    max_capacity = var.max_capacity
    min_capacity = var.min_capacity
  }

  lifecycle {
    prevent_destroy = true
  }
  depends_on = [aws_security_group.rds_security_group]
}

resource "aws_rds_cluster_instance" "rds_instance" {
  count = var.environment == "dev" ? 1 : 2
  identifier = "${var.cluster_identifier}-instance-${count.index}"
  cluster_identifier = aws_rds_cluster.rds_cluster.id
  instance_class     = var.instance_class
  engine             = aws_rds_cluster.rds_cluster.engine
  engine_version     = aws_rds_cluster.rds_cluster.engine_version
  db_subnet_group_name = aws_db_subnet_group.db_subnet_group.name
  depends_on = [aws_rds_cluster.rds_cluster]
}

resource "aws_security_group" "rds_security_group" {
  count = length(var.sg_specification)
  name = "${var.cluster_identifier}-db-sg"
  vpc_id = var.vpc_id
  tags = {
    Name : "${var.cluster_identifier}-sg-${var.environment}"
  }
  dynamic "ingress" {
    for_each = var.sg_specification[count.index].ingress_rules
    content {
      description      = ingress.value.description
      from_port        = ingress.value.from_port
      to_port          = ingress.value.to_port
      protocol         = ingress.value.protocol
      cidr_blocks      = ingress.value.cidr_blocks
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

resource "aws_db_subnet_group" "db_subnet_group" {
  name = "${var.cluster_identifier}-sng"
  subnet_ids = var.subnet_ids
  tags = var.default_tags
  description = "Subnet groups for ${var.cluster_identifier} cluster"
}