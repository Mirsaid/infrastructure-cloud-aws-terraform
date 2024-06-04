variable "vpc_id" {
  description = "The VPC ID"
}

variable "private_subnet_1a_ec2_id" {
  description = "The private subnet ID"
}

variable "public_subnet_1a_id" {
  description = "The public subnet ID"
}

variable "ec2_sg_id" {
  description = "The hosts security group ID"
}

variable "ami_id" {
  type = string
  #default = "ami-01a2825a801771f57" # Ubuntu 22.04 LTS AMI ID
  #default = "ami-0ab1a82de7ca5889c"
}

variable "instance_type" {
  type = string
  #default = "t2.micro" #"t3.micro" 
}

variable "key_name" {
  default = "dev-srv-key"
}

# variable "private_key_path" {
#     default = "./modules/vpc/dev-srv-key.pem"
# }

variable "availability_zone" {
  default = "eu-central-1a"
}

# variable "key_name" {
#   description = "The key name"
# }

variable "efs_dns_name" {
  description = "EFS dns name"
}

variable "app_efs_dns_name" {
  description = "APP EFS dns name"
}

# variable "ec2_s3_access_role" {
#   description = "The IAM role for S3 access"
# }
variable "name" {
  description = "Name of the ec2 server per env"
}
variable "ssh_user" {
  default = "ubuntu"
}
variable "private_key_path" {
  default = "./dev-srv-key.pem"
}