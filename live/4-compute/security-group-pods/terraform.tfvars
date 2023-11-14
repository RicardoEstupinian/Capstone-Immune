default_tags = {
  author      = "Grupo 4"
  project     = "capstone"
  environment = "dev"
  managed     = "terraform"
  team        = "devops"
}
region = "us-east-1"
vpc_id = "vpc-0ce0b35cd8d694981"
sg_specification = [
  {
    service_name = "microservice_1"
    ingress_rules = [{
      description     = "From Ingress ALB"
      from_port       = 9000
      to_port         = 9000
      protocol        = "tcp"
      cidr_blocks     = []
      security_groups = ["sg-0d6617a68c55eec62"] #SG ALB
    }]
    egress_rules = [{
      description = "Default egress rule"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }]
  }
]
project_name = "capstone"
environment  = "dev"