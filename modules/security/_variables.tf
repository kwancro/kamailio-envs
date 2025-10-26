
variable "environment" {
  type        = string
  default     = ""
  description = "Environment for which the rule will apply"
}

variable "vpc_id" {
  type        = string
  default     = ""
  description = "The VPC id"
}


# variable "ssh-allowed-inbound-subnets" {
#   type        = list(string)
#   description = "List of allowed inbound IPs for SSH"
# }

# variable "https-allowed-inbound-subnets" {
#   type        = list(string)
#   description = "List of allowed inbound IPs for HTTPS"
# }
variable "inbound_traffic" {
  type        = bool
  default     = false
  description = "Flag to build inbound traffic"
}

variable "outbound_traffic" {
  type        = bool
  default     = false
  description = "Flag to build outbound traffic"
}


variable "description" {
  type        = string
  default     = ""
  description = "Traffic description"
}

variable "from_port" {
  type        = number
#   default     = 0
  description = "Source port - start"
}

variable "to_port" {
  type        = number
#   default     = 0
  description = "Source port - end"
}

variable "protocol" {
  type        = string
#   default     = ""
  description = "Traffic protocol"
}

variable "cidr_blocks" {
  type        = list(string)
  default     = []
  description = "IP range"
}