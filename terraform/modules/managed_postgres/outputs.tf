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

