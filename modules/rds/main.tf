resource "aws_db_parameter_group" "mysql_parameter_group" {
  name        = "mysql-parameter-group-for-lower-case-table-names"
  family      = "mysql8.0" # Use the appropriate family for your MySQL version
  description = "Custom parameter group for MySQL with lower_case_table_names option"

  parameter {
    apply_method = "pending-reboot"
    name         = "lower_case_table_names"
    value        = "1"
  }
  parameter {
    apply_method = "immediate"
    name         = "max_allowed_packet"
    value        = "16777216" # 16M in bytes
  }
  #apply_method = "pending-reboot"
}

resource "aws_db_instance" "rds_mysql_db" {
  identifier              = var.identifier
  engine                  = var.engine
  engine_version          = var.engine_version
  instance_class          = var.instance_class
  allocated_storage       = var.allocated_storage
  max_allocated_storage   = var.max_allocated_storage
  username                = var.DB_USERNAME
  password                = var.DB_PASSWORD
  db_name                 = var.DB_NAME
  multi_az                = var.multi_az
  storage_type            = var.storage_type
  storage_encrypted       = var.storage_encrypted
  publicly_accessible     = var.publicly_accessible
  skip_final_snapshot     = var.skip_final_snapshot
  backup_retention_period = var.backup_retention_period
  #preferred_backup_window = var.preferred_backup_window
  monitoring_interval          = var.monitoring_interval
  performance_insights_enabled = var.performance_insights_enabled
  deletion_protection          = var.deletion_protection
  port                         = 3306
  #templates = "production"
  parameter_group_name   = aws_db_parameter_group.mysql_parameter_group.name
  apply_immediately      = true
  vpc_security_group_ids = [var.rds_sg_id]

  db_subnet_group_name = var.rds_subnet_group_id

  tags = {
    Name = "rds_mysql_db"
  }
}