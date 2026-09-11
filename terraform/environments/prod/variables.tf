variable "project_name" {
  description = "Nome base do projeto."
  type        = string
  default     = "autoservice"
}

variable "environment" {
  description = "Ambiente do deploy."
  type        = string
  default     = "homolog"
}

variable "aws_region" {
  description = "Regiao AWS para provisionamento."
  type        = string
  default     = "us-east-1"
}

variable "vpc_id" {
  description = "ID da VPC onde o banco sera provisionado."
  type        = string
}

variable "subnet_ids" {
  description = "Lista de subnets privadas para o subnet group do banco."
  type        = list(string)
  default     = []
}

variable "allowed_cidrs" {
  description = "CIDRs autorizados a acessar a porta do banco."
  type        = list(string)
  default     = []
}

variable "allowed_security_group_ids" {
  description = "Security Groups autorizados a acessar a porta do banco."
  type        = list(string)
  default     = []
}

variable "db_name" {
  description = "Nome inicial do banco."
  type        = string
  default     = "autoservice_db"
}

variable "db_username" {
  description = "Usuario administrador da instancia."
  type        = string
  default     = "postgres"
}

variable "db_password" {
  description = "Senha do usuario administrador."
  type        = string
  sensitive   = true
  default     = "Autoservice123!"
}

variable "engine_version" {
  description = "Versao do PostgreSQL."
  type        = string
  default     = "16.4"
}

variable "instance_class" {
  description = "Classe da instancia RDS."
  type        = string
  default     = "db.t4g.small"
}

variable "allocated_storage" {
  description = "Armazenamento inicial em GB."
  type        = number
  default     = 20
}

variable "max_allocated_storage" {
  description = "Escalabilidade automatica maxima de armazenamento em GB."
  type        = number
  default     = 100
}

variable "storage_type" {
  description = "Tipo de armazenamento RDS."
  type        = string
  default     = "gp3"
}

variable "backup_retention_period" {
  description = "Quantidade de dias de retencao de backup."
  type        = number
  default     = 0
}

variable "multi_az" {
  description = "Habilita alta disponibilidade Multi-AZ."
  type        = bool
  default     = false
}

variable "deletion_protection" {
  description = "Impede exclusao acidental da instancia."
  type        = bool
  default     = false
}

variable "performance_insights_enabled" {
  description = "Habilita Performance Insights."
  type        = bool
  default     = false
}

variable "monitoring_interval" {
  description = "Intervalo de monitoramento aprimorado em segundos."
  type        = number
  default     = 0
}

variable "apply_immediately" {
  description = "Aplica alteracoes imediatamente."
  type        = bool
  default     = true
}

variable "skip_final_snapshot" {
  description = "Nao gerar snapshot final ao destruir a instancia."
  type        = bool
  default     = true
}

variable "tags" {
  description = "Tags adicionais do projeto."
  type        = map(string)
  default     = {}
}