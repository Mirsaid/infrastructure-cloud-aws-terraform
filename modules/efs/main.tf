resource "aws_efs_file_system" "efs" {
  tags = {
    Name = "prod-efs-runtime"
  }
  throughput_mode = "elastic"
}

resource "aws_efs_mount_target" "efs_mount_target" {
  file_system_id  = aws_efs_file_system.efs.id
  subnet_id       = var.private_subnet_1a_ec2_id
  security_groups = [var.efs_sg_id]
}

resource "aws_efs_file_system" "app_efs" {
  tags = {
    Name = "application-efs"
  }
  throughput_mode = "elastic"
}


resource "aws_efs_mount_target" "app_efs_mount_target_1a" {
  file_system_id  = aws_efs_file_system.app_efs.id
  subnet_id       = var.private_subnet_1a_ec2_id
  security_groups = [var.efs_sg_id]
  ip_address      = "10.0.1.51"
}


resource "aws_efs_mount_target" "app_efs_mount_target_1b" {
  file_system_id  = aws_efs_file_system.app_efs.id
  subnet_id       = var.private_subnet_1b_ec2_id # Assuming this is your variable for the subnet in eu-central-1b
  security_groups = [var.efs_sg_id]
}