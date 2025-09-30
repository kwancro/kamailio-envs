variable "environment" {
  type        = string
  description = "Environment name (development/production)"
}

variable "ami" {
  type        = string
  description = "AMI ID for EC2 instance"
}

variable "instance_type" {
  type        = string
  description = "EC2 instance type"
}

variable "initial_ssh_key_name" {
  type        = string
  description = "description"
}