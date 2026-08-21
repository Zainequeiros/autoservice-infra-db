output "identifier" {
  description = "Identificador da instancia."
  value       = aws_db_instance.this.identifier
}

output "endpoint" {
  description = "Endpoint do banco."
  value       = aws_db_instance.this.address
}

output "port" {
  description = "Porta do banco."
  value       = aws_db_instance.this.port
}

output "security_group_id" {
  description = "Security Group do banco."
  value       = aws_security_group.db.id
}

output "arn" {
  description = "ARN da instancia RDS."
  value       = aws_db_instance.this.arn
}

output "db_name" {
  description = "Nome inicial do banco."
  value       = aws_db_instance.this.db_name
}

output "username" {
  description = "Usuario administrador da instancia."
  value       = aws_db_instance.this.username
}

output "subnet_group_name" {
  description = "Nome do DB subnet group."
  value       = aws_db_subnet_group.this.name
}

output "parameter_group_name" {
  description = "Nome do parameter group aplicado."
  value       = aws_db_parameter_group.this.name
}
