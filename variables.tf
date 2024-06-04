
variable "vpc_cidr" {
  description = "CIDR block for the VPC "
  type        = string
}

variable "ami_id" {
  description = "CIDR block for the VPC "
  type        = string
}
variable "instance_type" {
  description = "CIDR block for the VPC "
  type        = string
}

variable "cidr_block_private_eu_central_1a_ec2" {
  description = "CIDR block for the VPC "
  type        = string
}
variable "cidr_block_private_eu_central_1b_ec2" {
  description = "CIDR block for the VPC "
  type        = string
}
variable "cidr_block_private_eu_central_1a_rds" {
  description = "CIDR block for the VPC "
  type        = string
}
variable "cidr_block_private_eu_central_1b_rds" {
  description = "CIDR block for the VPC "
  type        = string
}
variable "cidr_block_public_eu_central_1a" {
  description = "CIDR block for the VPC "
  type        = string
}
variable "bucket_name" {
  description = "CIDR block for the VPC "
  type        = string
}
variable "name" {
  description = "Name of the server per env"
}

variable "DB_USERNAME" {
  description = "The username for RDS/MYSQL database"
}
variable "DB_PASSWORD" {
  description = "The password for RDS/MYSQL database"
}
variable "DB_NAME" {
  description = "The name for RDS/MYSQL database"
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

variable "operator_user_names" {
  description = "Operator Users for EKS access"
  type        = list(string)
}