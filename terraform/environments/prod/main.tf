module "managed_postgres" {
  source = "../../modules/managed_postgres"

  identifier                   = local.name
  db_name                      = var.db_name
  username                     = var.db_username
  password                     = var.db_password
  engine_version               = var.engine_version
  instance_class               = var.instance_class
  allocated_storage            = var.allocated_storage
  max_allocated_storage        = var.max_allocated_storage
  storage_type                 = var.storage_type
  backup_retention_period      = var.backup_retention_period
  multi_az                     = var.multi_az
  deletion_protection          = var.deletion_protection
  performance_insights_enabled = var.performance_insights_enabled
  monitoring_interval          = var.monitoring_interval
  apply_immediately            = var.apply_immediately
  skip_final_snapshot          = var.skip_final_snapshot
  vpc_id                       = var.vpc_id
  subnet_ids                   = var.subnet_ids
  allowed_cidrs                = var.allowed_cidrs
  allowed_security_group_ids   = var.allowed_security_group_ids
  tags                         = local.common_tags
}
