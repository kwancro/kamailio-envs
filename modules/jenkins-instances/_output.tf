output "jenkins-public-ips" {
  value       = aws_instance.instance.*.public_ip
  description = "honeypot public IP"
}

output "jenkins-instance-id" {
  value       = aws_instance.instance.id
  description = "Jenkins instance ID"
}
