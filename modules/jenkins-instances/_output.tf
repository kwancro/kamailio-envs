output "Jenkins-Public-IPs" {
  value       = aws_instance.instance.*.public_ip
  description = "honeypot public IP"
}