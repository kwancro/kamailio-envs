
variable "ssh-allowed-inbound-subnets" {
  type        = list(string)
  description = "List of allowed inbound IPs for SSH"
}

variable "https-allowed-inbound-subnets" {
  type        = list(string)
  description = "List of allowed inbound IPs for HTTPS"
}