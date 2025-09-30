variable "environment" {
  type        = string
  description = "Environment name (development/production)"
}

variable "cidr_block" {
  type        = string
  description = "CIDR block for the subnet"
}