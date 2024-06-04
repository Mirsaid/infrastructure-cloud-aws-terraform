variable "vpc_id" {
  description = "The VPC ID"
}

variable "private_eu_central_1a_rds_id" {
  description = "The RDS private subnet ID"
}

variable "private_eu_central_1b_rds_id" {
  description = "The RDS private subnet az2 ID"
}

variable "rds_subnet_group_id" {
  description = "The RDS  subnet group name"
}

variable "rds_sg_id" {
  description = "The RDS security group ID"
}

variable "DB_USERNAME" {
  #default = "myuser"
  description = "The username for MYSQL"
}
variable "DB_PASSWORD" {
  #default = "mypassword"
  description = "The password for MYSQL"
}
variable "DB_NAME" {
  #default = "mydb"
  description = "The name for MYSQL server"
}
variable "identifier" {
  description = "Identifier of RDS/MYSQL"
}
variable "engine" {
  description = "Engine for RDS/MYSQL"
}
variable "engine_version" {
  description = "Engine version of RDS/MYSQL "
}
variable "instance_class" {
  description = "Instance class of RDS/MYSQL"
}
variable "allocated_storage" {
  description = "Storage size of RDS/MYSQL"
}
variable "storage_type" {
  description = "Storage type of RDS/MYSQL"
}
variable "multi_az" {
  description = "Boolean for multi-az RDS/MYSQL"
}
variable "storage_encrypted" {
  description = "Boolean for storage_encrypted RDS/MYSQL"
}
variable "publicly_accessible" {
  description = "Boolean for publicly_accessible RDS/MYSQL"
}
variable "skip_final_snapshot" {
  description = "Boolean for skip_final_snapshot RDS/MYSQL"
}
variable "backup_retention_period" {
  description = "Boolean for backup_retention_period RDS/MYSQL"
}
variable "max_allocated_storage" {
  description = "Specifies the maximum storage limit in gigabytes for the RDS MySQL instance. This allows the RDS instance to automatically scale its allocated storage as needed, up to this maximum limit."
}

# variable "preferred_backup_window" {
#   description = "Defines the daily time window during which automated backups are created for the RDS instance. The format should be in UTC (e.g., 'hh:mm-hh:mm')."
# }

variable "monitoring_interval" {
  description = "Sets the interval, in seconds, for Enhanced Monitoring metrics collection for the RDS instance. Common values are 0 (disabled), 1, 5, 10, 15, 30, or 60."
}

variable "performance_insights_enabled" {
  description = "Enables or disables Performance Insights for the RDS instance. Set to 'true' to enable Performance Insights, which provides detailed database performance data."
}

variable "deletion_protection" {
  description = "Enables or disables deletion protection for the RDS instance. When set to 'true', the instance cannot be deleted, which helps prevent accidental data loss."
}

