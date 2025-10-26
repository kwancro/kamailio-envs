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
  description = "SSH key name for EC2 instance access"
}

variable "inbound_security_group_ids" {
  type        = list(string)
  description = "List of inbound security group IDs"
}

variable "outbound_security_group_ids" {
  type        = list(string)
  description = "List of outbound security group IDs"
}

variable "subnet_id" {
  type        = string
  description = "Subnet ID where the instance will be created"
}