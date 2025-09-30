variable "main_cidr_block" {
  type        = string
  default     = "172.31.0.0/16"
  description = "VPC Network range"
}

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


variable "environment" {
  type = map(object({
    #Environment = string
    cidr_block    = string
    ami           = string
    instance_type = string
  }))
  default = {
    development = {
      #Environment = development
      cidr_block    = "172.31.20.0/24"
      ami           = "ami-0c9e5f4bbf9701d5d"
      instance_type = "t3.micro"
    }
    production = {
      #Environment = production
      cidr_block    = "172.31.10.0/24"
      ami           = "ami-0c9e5f4bbf9701d5d"
      instance_type = "t3.micro"
    }
  }
}

variable "initial_ssh_key_name" {
  type        = string
  default     = "aws_ie-1"
  description = "Initial ssh key name to be used to access the instances"
}