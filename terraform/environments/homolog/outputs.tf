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

output "db_arn" {
  description = "ARN da instancia RDS."
  value       = module.managed_postgres.arn
}

output "db_name" {
  description = "Nome inicial do banco."
  value       = module.managed_postgres.db_name
}

output "db_username" {
  description = "Usuario administrador da instancia."
  value       = module.managed_postgres.username
}

output "security_group_id" {
  description = "Security Group criado para o banco."
  value       = module.managed_postgres.security_group_id
}

output "subnet_group_name" {
  description = "Subnet group aplicado ao banco."
  value       = module.managed_postgres.subnet_group_name
}

output "parameter_group_name" {
  description = "Parameter group aplicado ao banco."
  value       = module.managed_postgres.parameter_group_name
}

output "jdbc_url" {
  description = "JDBC URL consumida pela aplicacao Java."
  value       = "jdbc:postgresql://${module.managed_postgres.endpoint}:${module.managed_postgres.port}/${module.managed_postgres.db_name}"
}

output "lambda_environment" {
  description = "Mapa de variaveis para a Lambda de autenticacao."
  value = {
    DB_HOST = module.managed_postgres.endpoint
    DB_PORT = tostring(module.managed_postgres.port)
    DB_NAME = module.managed_postgres.db_name
    DB_USER = module.managed_postgres.username
  }
  sensitive = true
}

output "autoservice_environment" {
  description = "Mapa de variaveis para a aplicacao Spring Boot."
  value = {
    SPRING_DATASOURCE_URL      = "jdbc:postgresql://${module.managed_postgres.endpoint}:${module.managed_postgres.port}/${module.managed_postgres.db_name}"
    SPRING_DATASOURCE_USERNAME = module.managed_postgres.username
    DB_SECURITY_GROUP_ID       = module.managed_postgres.security_group_id
  }
  sensitive = true
}
