resource "aws_subnet" "private_eu_central_1a_ec2" {
  vpc_id                  = var.vpc_id
  cidr_block              = var.cidr_block_private_eu_central_1a_ec2
  availability_zone       = var.az_1a
  map_public_ip_on_launch = "false" #this subnet will be publicy accessible if you do not explicity set this to false

  tags = {
    "Name"                              = "private_ec2_subnet",
    "kubernetes.io/cluster/development" = "shared",
    "kubernetes.io/role/elb"            = "1"

  }

}

resource "aws_subnet" "private_eu_central_1b_ec2" {
  vpc_id                  = var.vpc_id
  cidr_block              = var.cidr_block_private_eu_central_1b_ec2
  availability_zone       = var.az_1b
  map_public_ip_on_launch = "false" #this subnet will be publicy accessible if you do not explicity set this to false

  tags = {
    "Name"                              = "private_ec2_subnet_az_1b",
    "kubernetes.io/cluster/development" = "shared",
    "kubernetes.io/role/internal-elb"   = "1"
  }
}

resource "aws_subnet" "private_eu_central_1a_rds" {
  vpc_id                  = var.vpc_id
  cidr_block              = var.cidr_block_private_eu_central_1a_rds
  availability_zone       = var.az_1a
  map_public_ip_on_launch = "false"

  tags = {
    "Name" = "private_rds_subnet"
  }
}

resource "aws_subnet" "private_eu_central_1b_rds" {
  vpc_id                  = var.vpc_id #Second subnet in different az for rds
  cidr_block              = var.cidr_block_private_eu_central_1b_rds
  availability_zone       = var.az_1b
  map_public_ip_on_launch = "false"

  tags = {
    "Name" = "private_rds_subnet"
  }
}
resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "db_subnet_group"
  subnet_ids = [aws_subnet.private_eu_central_1a_rds.id, aws_subnet.private_eu_central_1b_rds.id]
}

resource "aws_subnet" "public_eu_central_1a" {
  vpc_id                  = var.vpc_id
  cidr_block              = var.cidr_block_public_eu_central_1a
  availability_zone       = var.az_1a
  map_public_ip_on_launch = true

  tags = {
    "Name"                              = "public_subnet",
    "kubernetes.io/cluster/development" = "shared",
    "kubernetes.io/role/elb"            = "1"
  }
}