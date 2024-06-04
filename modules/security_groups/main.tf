#Security Groups 
resource "aws_security_group" "ec2_sg" {
  name   = "ec2_sg"
  vpc_id = var.vpc_id
}

resource "aws_security_group" "bastion_sg" {
  name   = "bastion_sg"
  vpc_id = var.vpc_id
}

resource "aws_security_group" "efs_sg" {
  name   = "efs_sg"
  vpc_id = var.vpc_id
}

resource "aws_security_group" "rds_sg" {
  name   = "rds_sg"
  vpc_id = var.vpc_id
}


#Security Group Rules

#EC2 Security Group Rules
#INGRESS
resource "aws_security_group_rule" "ingress_ec2_ssh_traffic" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  security_group_id = aws_security_group.ec2_sg.id
  cidr_blocks       = ["192.168.0.0/16"]
}

resource "aws_security_group_rule" "ingress_ec2_icmp_traffic" {
  type              = "ingress"
  from_port         = -1
  to_port           = -1
  protocol          = "icmp"
  security_group_id = aws_security_group.ec2_sg.id
  cidr_blocks       = ["192.168.0.0/16"]
}

resource "aws_security_group_rule" "ingress_ec2_samba_445" {
  type              = "ingress"
  from_port         = 445
  to_port           = 445
  protocol          = "tcp"
  security_group_id = aws_security_group.ec2_sg.id
  cidr_blocks       = ["192.168.0.0/16"]
}

resource "aws_security_group_rule" "ingress_ec2_samba_139" {
  type              = "ingress"
  from_port         = 139
  to_port           = 139
  protocol          = "tcp"
  security_group_id = aws_security_group.ec2_sg.id
  cidr_blocks       = ["192.168.0.0/16"]
}


#EGRESS
resource "aws_security_group_rule" "egress_ec2_traffic" {
  type              = "egress"
  from_port         = -1
  to_port           = -1
  protocol          = "all"
  security_group_id = aws_security_group.ec2_sg.id
  cidr_blocks       = ["0.0.0.0/0"]
}



#EFS Security Group Rules

#INGRESS
resource "aws_security_group_rule" "ingress_efs_vpc_traffic" {
  type              = "ingress"
  from_port         = -1 #2049
  to_port           = -1 #2049
  protocol          = "all"
  security_group_id = aws_security_group.efs_sg.id
  cidr_blocks       = ["10.0.0.0/8"]

}

resource "aws_security_group_rule" "ingress_efs_onprem_traffic" {
  type              = "ingress"
  from_port         = -1 #2049
  to_port           = -1 #2049
  protocol          = "all"
  security_group_id = aws_security_group.efs_sg.id
  cidr_blocks       = ["192.168.0.0/16"]

}

#EGRESS
resource "aws_security_group_rule" "egress_efs_vpc_traffic" {
  type              = "egress"
  from_port         = -1
  to_port           = -1
  protocol          = "all"
  security_group_id = aws_security_group.efs_sg.id
  cidr_blocks       = ["10.0.0.0/8"]

}
resource "aws_security_group_rule" "egress_efs_onprem_traffic_" {
  type              = "egress"
  from_port         = -1
  to_port           = -1
  protocol          = "all"
  security_group_id = aws_security_group.efs_sg.id
  cidr_blocks       = ["192.168.0.0/16"]
}

#RDS Security Group Rules

#INGRESS
resource "aws_security_group_rule" "ingress_mysql_ssh_traffic" {
  type              = "ingress"
  from_port         = 3306
  to_port           = 3306
  protocol          = "tcp"
  security_group_id = aws_security_group.rds_sg.id
  cidr_blocks       = ["10.0.0.0/16"]

}

#need to change and give more specific permissions or delete
resource "aws_security_group_rule" "ingress_rds_from_office_traffic" {
  type              = "ingress"
  from_port         = -1
  to_port           = -1
  protocol          = "all"
  security_group_id = aws_security_group.rds_sg.id
  cidr_blocks       = ["192.168.0.0/16"]

}

resource "aws_security_group_rule" "ingress_rds_from_env_staging" {
  type              = "ingress"
  from_port         = -1
  to_port           = -1
  protocol          = "all"
  security_group_id = aws_security_group.rds_sg.id
  cidr_blocks       = ["10.1.0.0/16"]

}

resource "aws_security_group_rule" "ingress_rds_from_env_prod" {
  type              = "ingress"
  from_port         = -1
  to_port           = -1
  protocol          = "all"
  security_group_id = aws_security_group.rds_sg.id
  cidr_blocks       = ["10.2.0.0/16"]

}
#EGRESS
resource "aws_security_group_rule" "egress_rds_traffic" {
  type              = "egress"
  from_port         = -1
  to_port           = -1
  protocol          = "all" #need to change and give more specific permissions
  security_group_id = aws_security_group.rds_sg.id
  cidr_blocks       = ["0.0.0.0/0"]

}

