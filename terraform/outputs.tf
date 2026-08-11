output "db_endpoint" {
  description = "Endpoint de conexao do banco."
  value       = module.managed_postgres.endpoint
}

output "db_port" {
  description = "Porta exposta pela instancia."
  value       = module.managed_postgres.port
}

output "db_identifier" {
  description = "Identificador da instancia."
  value       = module.managed_postgres.identifier
}

output "security_group_id" {
  description = "Security Group criado para o banco."
  value       = module.managed_postgres.security_group_id
}

