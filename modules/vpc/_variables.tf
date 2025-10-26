variable "main_cidr_block" {
  type        = string
  description = "VPC Network range"
}

variable "vpc_name" {
  type        = string
  default     = "kamailio-build"
  description = "The name of the VPC to use for the deployment"
}
