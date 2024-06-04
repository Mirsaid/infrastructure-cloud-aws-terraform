output "ec2_instance_id" {
  value = aws_instance.ec2_instance_private.id
}

output "ec2_server_private_ip" {
  value = aws_instance.ec2_instance_private.private_ip
}

# output "ec2_server_2_private_ip" {
#   value = aws_instance.ec2_instance_2.private_ip
# }