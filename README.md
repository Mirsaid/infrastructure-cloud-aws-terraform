# Terraform Infrastructure Deployment
This repository contains Terraform code to deploy infrastructure components. Please ensure that you have the required permissions and configurations before applying the Terraform code.

## Table of Contents

- [Prerequisites](#prerequisites)
- [Initialization](#initialization)
- [Planning](#planning)
- [Applying Changes](#applying-changes)
- [Cleanup](#cleanup)
- [Module Descriptions](#module-descriptions)
- [Inputs](#inputs)
- [Outputs](#outputs)

## Prerequisites
- Install Terraform
- Configure AWS credentials
- Familiarity with .tfvars format for inputting variables

# Configure AWS credentials
- Configuring AWS CLI Profiles:
Before deploying the Terraform infrastructure, it's essential to configure your AWS CLI with the appropriate credentials and settings. This enables Terraform to interact with AWS services on your behalf. Here's how to set up an AWS CLI profile named "your_name":
```
aws configure --profile your_name

```
- Enter Your Credentials and Configurations: You'll be prompted to enter several pieces of information:

AWS Access Key ID: Your access key.
AWS Secret Access Key: Your secret key.
Default region name: us-west-1.
Default output format: json.


- Verification: To verify that your profile has been set up correctly, you can list all configured profiles:
```
aws configure list-profiles

```
You should see your_name listed among the profiles.

## Initialization
- Before running any Terraform commands, initialize your working directory:

```
terraform init
```

## Planning
- Before applying changes, it's good practice to preview the changes that will be made. Use the following command to generate a plan:

```
terraform plan -var-file="prod.tfvars" -out=plan.out
```
## Applying Changes
- Once you've reviewed and verified the changes from the plan step, you can apply them using the following command:

```
terraform apply plan.out
```
## Cleanup
- To destroy the resources you've created, use the following commands:

```
terraform plan -destroy -var-file="prod.tfvars" -out=destroy.out
terraform apply destroy.out```
OR
terraform destroy -var-file=prod.tfvars
```

### Module Descriptions

- The project is organized into multiple modules, each responsible for deploying a specific part of the infrastructure. Below is a breakdown of each module and its components:

- EC2 Server
Location: modules/ec2_server
Components:
cloud-init.tpl: Cloud-Init template to initialize EC2 instances "ansible" user and mount "efs" fs.
main.tf: Terraform configuration for EC2 instances.
outputs.tf: Outputs related to EC2 instances.
variables.tf: Variables required for EC2 module.

- Elastic File System (EFS)
Location: modules/efs
Components:
main.tf: Configuration for EFS resources.
outputs.tf: Outputs for EFS module.
variables.tf: Variables for EFS configuration.

- IAM
Location: modules/iam
Components:
main.tf: Terraform configurations for IAM roles and policies.
outputs.tf: Outputs for IAM resources.
variables.tf: Variables related to IAM.

- Network
This module contains submodules for different networking components:

- VPC Network Components:
Location: modules/network/igw,nat,routes,subnets,transit_gw_vpn,vpc
Components:
main.tf
outputs.tf
variables.tf

- RDS
Location: modules/rds
Components:
main.tf
outputs.tf
variables.tf

- Security Groups
Location: modules/security_groups
Components:
main.tf
outputs.tf
variables.tf

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 5.9.0 |


## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_ec2_server"></a> [EC2 Server](#module\_ec2\_server) | ./modules/ec2_server | n/a |
| <a name="module_efs"></a> [Elastic File System](#module\_efs) | ./modules/efs | n/a |
| <a name="module_igw"></a> [Internet Gateway](#module\_igw) | ./modules/igw | n/a |
| <a name="module_nat"></a> [NAT](#module\_nat) | ./modules/nat | n/a |
| <a name="module_rds"></a> [Relational Database Service](#module\_rds) | ./modules/rds | n/a |
| <a name="module_routes"></a> [Routes](#module\_routes) | ./modules/routes | n/a |
| <a name="module_security_groups"></a> [Security Groups](#module\_security\_groups) | ./modules/security_groups | n/a |
| <a name="module_subnets"></a> [Subnets](#module\_subnets) | ./modules/subnets | n/a |
| <a name="module_transit_gw_vpn"></a> [Transit Gateway](#module\_transit\_gw\_vpn) | ./modules/transit_gw_vpn | n/a |
| <a name="module_vpc"></a> [Virtual Private Cloud](#module\_vpc) | ./modules/vpc | n/a |


## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_DB_NAME"></a> [DB\_NAME](#input\_DB\_NAME) | The name for RDS/MYSQL database | `any` | n/a | yes |
| <a name="input_DB_PASSWORD"></a> [DB\_PASSWORD](#input\_DB\_PASSWORD) | The password for RDS/MYSQL database | `any` | n/a | yes |
| <a name="input_DB_USERNAME"></a> [DB\_USERNAME](#input\_DB\_USERNAME) | The username for RDS/MYSQL database | `any` | n/a | yes |
| <a name="input_allocated_storage"></a> [allocated\_storage](#input\_allocated\_storage) | Storage size of RDS/MYSQL | `any` | n/a | yes |
| <a name="input_ami_id"></a> [ami\_id](#input\_ami\_id) | AMI ID for EC2 instance | `string` | n/a | yes |
| <a name="input_backup_retention_period"></a> [backup\_retention\_period](#input\_backup\_retention\_period) | Backup retention period for RDS/MYSQL in days | `any` | n/a | yes |
| <a name="input_bucket_name"></a> [bucket\_name](#input\_bucket\_name) | Bucket name for S3 bucket, state stored | `string` | n/a | yes |
| <a name="input_cidr_block_private_eu_central_1a_ec2"></a> [cidr\_block\_private\_eu\_central\_1a\_ec2](#input\_cidr\_block\_private\_eu\_central\_1a\_ec2) | CIDR block for the EC2 | `string` | n/a | yes |
| <a name="input_cidr_block_private_eu_central_1a_rds"></a> [cidr\_block\_private\_eu\_central\_1a\_rds](#input\_cidr\_block\_private\_eu\_central\_1a\_rds) | CIDR block for the RDS1  | `string` | n/a | yes |
| <a name="input_cidr_block_private_eu_central_1b_rds"></a> [cidr\_block\_private\_eu\_central\_1b\_rds](#input\_cidr\_block\_private\_eu\_central\_1b\_rds) | CIDR block for the RDS2 | `string` | n/a | yes |
| <a name="input_cidr_block_public_eu_central_1a"></a> [cidr\_block\_public\_eu\_central\_1a](#input\_cidr\_block\_public\_eu\_central\_1a) | CIDR block for the public subnet  | `string` | n/a | no |
| <a name="input_engine"></a> [engine](#input\_engine) | Engine for RDS/MYSQL | `any` | n/a | yes |
| <a name="input_engine_version"></a> [engine\_version](#input\_engine\_version) | Engine version of RDS/MYSQL | `any` | n/a | yes |
| <a name="input_identifier"></a> [identifier](#input\_identifier) | Identifier of RDS/MYSQL | `any` | n/a | yes |
| <a name="input_instance_class"></a> [instance\_class](#input\_instance\_class) | Instance class of RDS/MYSQL | `any` | n/a | yes |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | Type of EC2 instance | `string` | n/a | yes |
| <a name="input_multi_az"></a> [multi\_az](#input\_multi\_az) | Boolean for multi-az RDS/MYSQL | `any` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Name of the EC2 server  | `any` | n/a | yes |
| <a name="input_publicly_accessible"></a> [publicly\_accessible](#input\_publicly\_accessible) | Boolean for publicly\_accessible RDS/MYSQL | `any` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | Frankfurt region | `string` | `"eu-central-1"` | no |
| <a name="input_skip_final_snapshot"></a> [skip\_final\_snapshot](#input\_skip\_final\_snapshot) | Boolean for skip\_final\_snapshot RDS/MYSQL | `any` | n/a | yes |
| <a name="input_storage_encrypted"></a> [storage\_encrypted](#input\_storage\_encrypted) | Boolean for storage\_encrypted RDS/MYSQL | `any` | n/a | yes |
| <a name="input_storage_type"></a> [storage\_type](#input\_storage\_type) | Storage type of RDS/MYSQL | `any` | n/a | yes |
| <a name="input_vpc_cidr"></a> [vpc\_cidr](#input\_vpc\_cidr) | CIDR block for the VPC | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ec2_server_private_ip"></a> [ec2\_server\_private\_ip](#output\_ec2\_server\_private\_ip) | n/a |

