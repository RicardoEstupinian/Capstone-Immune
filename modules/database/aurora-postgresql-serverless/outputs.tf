output "db_endpoint" {
  value       = aws_rds_cluster.rds_cluster.endpoint
  description = "Connect to the database at this endpoint"
}

output "db_port" {
  value       = aws_rds_cluster.rds_cluster.port
  description = "The port the database is listening on"
}

output "db_name" {
  value       = aws_rds_cluster.rds_cluster.database_name
  description = "Database name"
  sensitive = true
}

output "db_master_username" {
  value       = aws_rds_cluster.rds_cluster.master_username
  description = "DB master username"
  sensitive = true
}

output "db_master_password" {
  value       = aws_rds_cluster.rds_cluster.master_password
  description = "DB master password"
  sensitive = true
}