module "vpc" {
  source   = "./modules/network/vpc"
  vpc_cidr = var.vpc_cidr
}

module "subnets" {
  source                               = "./modules/network/subnets"
  vpc_id                               = module.vpc.vpc_id
  cidr_block_private_eu_central_1a_ec2 = var.cidr_block_private_eu_central_1a_ec2
  cidr_block_private_eu_central_1b_ec2 = var.cidr_block_private_eu_central_1b_ec2
  cidr_block_private_eu_central_1a_rds = var.cidr_block_private_eu_central_1a_rds
  cidr_block_private_eu_central_1b_rds = var.cidr_block_private_eu_central_1b_rds
  cidr_block_public_eu_central_1a      = var.cidr_block_public_eu_central_1a
}


module "igw" {
  source = "./modules/network/igw"
  vpc_id = module.vpc.vpc_id
}

module "nat" {
  source              = "./modules/network/nat"
  public_subnet_1a_id = module.subnets.public_subnet_1a_id
  igw_id              = module.igw.igw_id
  depends_on          = [module.igw]
}

module "routes" {
  source                       = "./modules/network/routes"
  vpc_id                       = module.vpc.vpc_id
  private_subnet_1a_ec2_id     = module.subnets.private_subnet_1a_ec2_id
  private_eu_central_1a_rds_id = module.subnets.private_eu_central_1a_rds_id
  private_eu_central_1b_rds_id = module.subnets.private_eu_central_1b_rds_id
  public_subnet_1a_id          = module.subnets.public_subnet_1a_id
  nat_gw_id                    = module.nat.nat_gw_id
  igw_id                       = module.igw.igw_id
  tgw_vpn_id                   = module.transit_gw_vpn.tgw_vpn_id
}


module "ec2_server" {
  source                   = "./modules/ec2_server"
  vpc_id                   = module.vpc.vpc_id
  private_subnet_1a_ec2_id = module.subnets.private_subnet_1a_ec2_id
  public_subnet_1a_id      = module.subnets.public_subnet_1a_id
  ec2_sg_id                = module.security_groups.ec2_sg_id
  efs_dns_name             = module.efs.efs_dns_name
  app_efs_dns_name         = module.efs.app_efs_dns_name
  depends_on               = [module.efs]
  ami_id                   = var.ami_id
  instance_type            = var.instance_type
  name                     = var.name
}

module "rds" {
  source                       = "./modules/rds"
  rds_subnet_group_id          = module.subnets.rds_subnet_group_id
  private_eu_central_1a_rds_id = module.subnets.private_eu_central_1a_rds_id
  private_eu_central_1b_rds_id = module.subnets.private_eu_central_1b_rds_id
  rds_sg_id                    = module.security_groups.rds_sg_id
  vpc_id                       = module.vpc.vpc_id
  DB_USERNAME                  = var.DB_USERNAME
  DB_PASSWORD                  = var.DB_PASSWORD
  DB_NAME                      = var.DB_NAME
  identifier                   = var.identifier
  engine                       = var.engine
  engine_version               = var.engine_version
  instance_class               = var.instance_class
  allocated_storage            = var.allocated_storage
  max_allocated_storage        = var.max_allocated_storage
  multi_az                     = var.multi_az
  storage_type                 = var.storage_type
  storage_encrypted            = var.storage_encrypted
  publicly_accessible          = var.publicly_accessible
  skip_final_snapshot          = var.skip_final_snapshot
  backup_retention_period      = var.backup_retention_period
  #preferred_backup_window = var.preferred_backup_window
  monitoring_interval          = var.monitoring_interval
  performance_insights_enabled = var.performance_insights_enabled
  deletion_protection          = var.deletion_protection
}


module "efs" {
  source                   = "./modules/efs"
  efs_sg_id                = module.security_groups.efs_sg_id
  private_subnet_1a_ec2_id = module.subnets.private_subnet_1a_ec2_id
  private_subnet_1b_ec2_id = module.subnets.private_subnet_1b_ec2_id

}

module "security_groups" {
  source = "./modules/security_groups"
  vpc_id = module.vpc.vpc_id
  # eip_ip = module.nat.eip_ip
}


module "transit_gw_vpn" {
  source                       = "./modules/network/transit_gw_vpn"
  vpc_id                       = module.vpc.vpc_id
  private_eu_central_1a_rds_id = module.subnets.private_eu_central_1a_rds_id
  private_eu_central_1b_rds_id = module.subnets.private_eu_central_1b_rds_id
  private_subnet_1a_ec2_id     = module.subnets.private_subnet_1a_ec2_id
  private_subnet_1b_ec2_id     = module.subnets.private_subnet_1b_ec2_id
  # tgw_vpn_id = aws_ec2_transit_gateway.this.id

}

module "iam" {
  source              = "./modules/iam"
  operator_user_names = var.operator_user_names
}

output "ec2_server_private_ip" {
  value = module.ec2_server.ec2_server_private_ip

}

output "iam_user_access_keys" {
  value     = module.iam.user_access_keys
  sensitive = true
}
