# Create a RDS Postgres cluster

module "rds_cluster" {
  source             = "../../../modules/database/aurora-postgresql-serverless"
  cluster_identifier = var.cluster_identifier
  db_username        = var.db_username
  db_password        = var.db_password
  engine             = var.engine
  engine_mode        = var.engine_mode
  engine_version     = var.engine_version
  database_name      = var.database_name
  max_capacity       = var.max_capacity
  min_capacity       = var.min_capacity
  instance_class     = var.instance_class
  subnet_ids         = var.subnet_ids
  vpc_id             = var.vpc_id
  region             = var.region
  default_tags       = var.default_tags
  environment        = var.environment
  project_name       = var.project_name
  sg_specification   = var.sg_specification
}
