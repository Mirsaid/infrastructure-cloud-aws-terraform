variable "vpc_id" {
  description = "The ID of the VPC"
}
variable "az_1a" {
  default = "eu-central-1a"
}
variable "az_1b" {
  default = "eu-central-1b"
}
variable "cidr_block_private_eu_central_1a_ec2" {
  description = "cidr block for private_eu_central_1a_ec2 prod environment"
}
variable "cidr_block_private_eu_central_1b_ec2" {
  description = "cidr block for private_eu_central_1b_ec2 prod environment"
}

variable "cidr_block_private_eu_central_1a_rds" {
  description = "cidr block for private_eu_central_1a_rds prod environment"
}

variable "cidr_block_private_eu_central_1b_rds" {
  description = "cidr block for private_eu_central_1b_rds prod environment"
}

variable "cidr_block_public_eu_central_1a" {
  description = "cidr block for public_eu_central_1a prod environment"
}
