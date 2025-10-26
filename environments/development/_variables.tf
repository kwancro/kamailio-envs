variable "region" {
  type        = string
  default     = "eu-west-1"
  description = "AWS region to use"
}


variable "environment" {
  type        = string
  default     = "development"
  description = "Envirnoment name"
}

# variable "ssh-allowed-inbound-subnets" {
#   type        = list(any)
#   default     = ["0.0.0.0/0"]
#   description = "List of allowed inbound IPs"
# }

# variable "https-allowed-inbound-subnets" {
#   type        = list(any)
#   default     = ["0.0.0.0/0"]
#   description = "List of allowed inbound IPs"
# }

# Subnet
variable "cidr_block" {
  type        = string
  default     = "172.31.20.0/24"
  description = "Envirnoment IP block range"
}

# Storage/Volume
variable "packages_disk_volume" {
  type        = number
  default     = 100
  description = "Disk volume size in GB to store packages"
}


# VM details
variable "ami" {
  type        = string
  default     = "ami-0c9e5f4bbf9701d5d"
  description = "AMI to use"
}
variable "instance_type" {
  type        = string
  default     = "t1.micro"
  description = "Envirnoment instance type"
}

# Access keys
variable "initial_ssh_key_name" {
  type        = string
  default     = "aws_ie-1"
  description = "Initial ssh key name to be used to access the instances"
}

# Firewall rules

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

variable "inbound_allowed_traffic" {
  type = map(object({
    # description = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
  default = {
    ssh = {
      #   description = string
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
    https = {
      #   description = string
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
}

variable "outbound_allowed_traffic" {
  type = map(object({
    # description = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
  default = {
    all = {
      #   description = string
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
}

