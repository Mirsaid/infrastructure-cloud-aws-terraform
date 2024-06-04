#Transit Gateway
resource "aws_ec2_transit_gateway" "this" {

  tags = {
    "Name" = "TGW-01"
  }
  description                     = "Transit Gateway"
  dns_support                     = "enable"
  auto_accept_shared_attachments  = "disable"
  default_route_table_association = "disable"
  default_route_table_propagation = "disable"
  vpn_ecmp_support                = "enable"
}

# Attach VPCs to the Transit Gateway
resource "aws_ec2_transit_gateway_vpc_attachment" "prod_vpc_attach" {
  transit_gateway_id = aws_ec2_transit_gateway.this.id
  vpc_id             = var.vpc_id
  subnet_ids         = [var.private_subnet_1a_ec2_id, var.private_subnet_1b_ec2_id]
  tags = {
    Name = "tgw-att-prod-vpc-01"
  }
  transit_gateway_default_route_table_association = false
  transit_gateway_default_route_table_propagation = false
}


# Customer Gateway
resource "aws_customer_gateway" " " {

  ip_address = "87.138.105.2" # Replace with the actual IP address of your on-premises VPN device
  type       = "ipsec.1"
  bgp_asn    = "65000"
  tags = {
    Name = "CGW-01"
  }

}


# Transit Gateway Route Tables
resource "aws_ec2_transit_gateway_route_table" "vpc_route_table" {
  transit_gateway_id = aws_ec2_transit_gateway.this.id
  tags = {
    Name = "VPCs-Route-Table-01"
  }

}

resource "aws_ec2_transit_gateway_route_table" "vpn_route_table" {
  transit_gateway_id = aws_ec2_transit_gateway.this.id
  tags = {
    Name = "VPN-Route-Table-01"
  }

}

#Routes
resource "aws_ec2_transit_gateway_route" "vpc_route" {
  destination_cidr_block         = "192.168.0.0/16"
  transit_gateway_attachment_id  = aws_vpn_connection.vpn.transit_gateway_attachment_id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.vpc_route_table.id
  blackhole                      = false

}
resource "aws_ec2_transit_gateway_route" "vpn_route" {
  destination_cidr_block         = "10.0.0.0/16"
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.prod_vpc_attach.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.vpn_route_table.id
  blackhole                      = false
}


# Site-to-Site VPN Connection with Static Routing
resource "aws_vpn_connection" "vpn" {

  customer_gateway_id      = aws_customer_gateway.customer_gw.id
  transit_gateway_id       = aws_ec2_transit_gateway.this.id
  type                     = aws_customer_gateway.customer_gw.type
  static_routes_only       = true
  local_ipv4_network_cidr  = "0.0.0.0/0"
  remote_ipv4_network_cidr = "0.0.0.0/0"
  tags = {
    Name = "vpn-01"
  }

}

# Associations and Propagations
resource "aws_ec2_transit_gateway_route_table_association" "prod_vpc_association" {
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.vpc_route_table.id
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.prod_vpc_attach.id
}

resource "aws_ec2_transit_gateway_route_table_association" "vpn_association" {
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.vpn_route_table.id
  transit_gateway_attachment_id  = aws_vpn_connection.vpn.transit_gateway_attachment_id
}

