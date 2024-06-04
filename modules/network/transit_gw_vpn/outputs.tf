# output "test" {
#     value   = data.aws_ec2_transit_gateway_vpn_attachment.vpn_attachement_data.id
# }

output "tgw_vpn_id" {
  value = aws_ec2_transit_gateway.this.id
}