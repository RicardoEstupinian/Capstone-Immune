default_tags = {
  author      = "Grupo 4"
  project     = "capstone"
  environment = "dev"
  managed     = "terraform"
  team        = "devops"
}
region             = "us-east-1"
environment        = "dev"
project_name       = "capstone"
cluster_identifier = "investments"
db_username        = "investments_usr_master"
db_password        = "441EZ30bT0oZZZRrre90"
engine             = "aurora-postgresql"
engine_mode        = "provisioned"
engine_version     = "13.6"
database_name      = "investments_db"
max_capacity       = 1.0
min_capacity       = 0.5
instance_class     = "db.serverless"
vpc_id = "vpc-0ce0b35cd8d694981"
subnet_ids = [
  "subnet-0078b5f90983db917",
  "subnet-0b07c7694d4cf2abc"
]
sg_specification = [
  {
    service_name = "microservice_1"
    ingress_rules = [
      {
        from_port   = 9000
        to_port     = 9000
        protocol    = "tcp"
        cidr_blocks = ["192.168.0.45/32"]
        description = "From microservice 1"
      }
    ]
    egress_rules = []
  }
]
