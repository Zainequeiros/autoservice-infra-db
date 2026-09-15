variable "identifier" {
  description = "Identificador unico da instancia."
  type        = string
}

variable "db_name" {
  description = "Nome inicial do banco."
  type        = string
}

variable "username" {
  description = "Usuario administrador."
  type        = string
}

variable "password" {
  description = "Senha do usuario administrador."
  type        = string
  sensitive   = true
}

variable "engine_version" {
  description = "Versao do PostgreSQL."
  type        = string
}

variable "instance_class" {
  description = "Classe da instancia."
  type        = string
}

variable "allocated_storage" {
  description = "Armazenamento inicial em GB."
  type        = number
}

variable "max_allocated_storage" {
  description = "Escalabilidade maxima de armazenamento."
  type        = number
}

variable "storage_type" {
  description = "Tipo de armazenamento."
  type        = string
}

variable "backup_retention_period" {
  description = "Dias de retencao de backup."
  type        = number
}

variable "multi_az" {
  description = "Habilita Multi-AZ."
  type        = bool
}

variable "deletion_protection" {
  description = "Habilita protecao contra exclusao."
  type        = bool
}

variable "performance_insights_enabled" {
  description = "Habilita Performance Insights."
  type        = bool
}

variable "monitoring_interval" {
  description = "Intervalo de monitoramento aprimorado."
  type        = number
}

variable "apply_immediately" {
  description = "Aplica alteracoes imediatamente."
  type        = bool
}

variable "skip_final_snapshot" {
  description = "Pula o snapshot final na destruicao."
  type        = bool
}

variable "vpc_id" {
  description = "ID da VPC."
  type        = string
}

variable "subnet_ids" {
  description = "Subnets do subnet group."
  type        = list(string)
}

variable "allowed_cidrs" {
  description = "CIDRs com acesso permitido ao banco."
  type        = list(string)
  default     = []
}

variable "allowed_security_group_ids" {
  description = "Security Groups autorizados a acessar o banco."
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "Tags adicionais."
  type        = map(string)
}
