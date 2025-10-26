variable "ssh-allowed-inbound-subnets" {
  type        = list(any)
  default     = ["0.0.0.0/0"]
  description = "List of allowed inbound IPs"
}

variable "https-allowed-inbound-subnets" {
  type        = list(any)
  default     = ["0.0.0.0/0"]
  description = "List of allowed inbound IPs"
}