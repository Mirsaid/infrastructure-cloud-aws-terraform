output "efs_dns_name" {
  value = aws_efs_file_system.efs.dns_name
}

output "efs_id" {
  value = aws_efs_file_system.efs.id
}
output "app_efs_dns_name" {
  value = aws_efs_file_system.app_efs.dns_name
}

output "app_efs_id" {
  value = aws_efs_file_system.app_efs.id
}


# output "efs_mount_target_id" {
#     value = aws_efs_mount_target.matlab_runtime.id
# }