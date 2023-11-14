output "endpoint" {
  value       = module.rds_cluster.db_endpoint
  description = "Connect to the database at this endpoint"
}

output "port" {
  value       = module.rds_cluster.db_port
  description = "The port the database is listening on"
}
