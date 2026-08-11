resource "aws_security_group" "db" {
  name        = "${var.identifier}-db-sg"
  description = "Acesso ao banco PostgreSQL do AutoService"
  vpc_id      = var.vpc_id

  ingress {
    description = "PostgreSQL"
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = var.allowed_cidrs
  }

  egress {
    description = "Saida padrao"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.tags, { Name = "${var.identifier}-db-sg" })
}

resource "aws_db_subnet_group" "this" {
  name       = "${var.identifier}-subnet-group"
  subnet_ids = var.subnet_ids

  tags = merge(var.tags, { Name = "${var.identifier}-subnet-group" })
}

resource "aws_db_parameter_group" "this" {
  name   = "${var.identifier}-postgres16"
  family = "postgres16"

  parameter {
    name  = "rds.force_ssl"
    value = "1"
  }

  parameter {
    name  = "log_min_duration_statement"
    value = "500"
  }

  tags = merge(var.tags, { Name = "${var.identifier}-postgres16" })
}

resource "aws_db_instance" "this" {
  identifier                          = var.identifier
  engine                              = "postgres"
  engine_version                      = var.engine_version
  db_name                             = var.db_name
  username                            = var.username
  password                            = var.password
  instance_class                      = var.instance_class
  allocated_storage                   = var.allocated_storage
  max_allocated_storage               = var.max_allocated_storage
  storage_type                        = var.storage_type
  storage_encrypted                   = true
  port                                = 5432
  backup_retention_period             = var.backup_retention_period
  backup_window                       = "03:00-04:00"
  maintenance_window                  = "Sun:04:00-Sun:05:00"
  multi_az                            = var.multi_az
  deletion_protection                 = var.deletion_protection
  performance_insights_enabled        = var.performance_insights_enabled
  monitoring_interval                 = var.monitoring_interval
  apply_immediately                   = var.apply_immediately
  skip_final_snapshot                 = var.skip_final_snapshot
  final_snapshot_identifier           = var.skip_final_snapshot ? null : "${var.identifier}-final"
  publicly_accessible                 = false
  auto_minor_version_upgrade          = true
  iam_database_authentication_enabled = false
  db_subnet_group_name                = aws_db_subnet_group.this.name
  vpc_security_group_ids              = [aws_security_group.db.id]
  parameter_group_name                = aws_db_parameter_group.this.name
  enabled_cloudwatch_logs_exports     = ["postgresql", "upgrade"]
  copy_tags_to_snapshot               = true

  tags = merge(var.tags, { Name = var.identifier })
}

