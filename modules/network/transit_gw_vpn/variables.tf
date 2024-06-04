variable "vpc_id" {
  description = "The ID of the VPC"
}
variable "private_eu_central_1a_rds_id" {
  description = "cidr block for private_eu_central_1a_rds prod environment"
}
variable "private_eu_central_1b_rds_id" {
  description = "cidr block for private_eu_central_1b_rds prod environment"
}
variable "private_subnet_1a_ec2_id" {
  description = "cidr block for private_subnet_1a_ec2_id prod environment"
}

variable "private_subnet_1b_ec2_id" {
  description = "cidr block for private_subnet_1a_ec2_id prod environment"
}