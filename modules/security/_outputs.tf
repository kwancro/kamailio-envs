output "inbound_security_group_id" {
  description = "ID of the inbound security group"
  value       = aws_security_group.inbound-traffic[0].id
}

output "outbound_security_group_id" {
  description = "ID of the outbound security group"
  value       = aws_security_group.outbound-traffic[0].id
}