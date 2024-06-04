resource "aws_instance" "ec2_instance_private" {
  ami = var.ami_id
  #iam_instance_profile   = aws_iam_instance_profile.ec2_profile.name
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = [var.ec2_sg_id]
  availability_zone      = var.availability_zone
  subnet_id              = var.private_subnet_1a_ec2_id #public_subnet_1a_id
  monitoring             = true
  private_ip             = "10.0.1.100"


  # Cloud-init.tpl
  user_data = data.template_file.cloud_init.rendered

  #Add a root EBS volume
  root_block_device {
    delete_on_termination = false
    tags = {
      Name   = "EC2 Root Volume"
      Backup = "true"
      # Env    = "prod"
    }
  }
  tags = {
    Name = "aws"
    Role = "Core Server"
    Env  = "production"

  }
}

resource "aws_ebs_volume" "root_volume" {
  availability_zone = var.availability_zone
  size              = 30    # Volume size in GiB
  type              = "gp3" # Volume type


  tags = {
    Name   = "EC2 Root Volume"
    Backup = "true"
  }
}

# resource "aws_volume_attachment" "attach_root_volume" {
#   device_name  = "/dev/sda1"
#   volume_id    = aws_ebs_volume.root_volume.id
#   instance_id  = aws_instance.ec2_instance_private.id
#   force_detach = true
# }

data "template_file" "cloud_init" {
  template = file("${path.module}/cloud-init.tpl")

  vars = {
    efs_dns_name = var.efs_dns_name
  }
}