terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

# Create Global infra
## Create VPC
module "vpc" {
  source = "./modules/vpc"
  vpc_name = var.vpc_name
  main_cidr_block = var.main_cidr_block
}

# ## Create Security groups
# module "sg" {
#   source                        = "./modules/security"
#   depends_on                    = [module.vpc]
#   ssh-allowed-inbound-subnets   = var.ssh-allowed-inbound-subnets
#   https-allowed-inbound-subnets = var.https-allowed-inbound-subnets
# }


# ## Create Environment networks
# module "networking" {
#   for_each   = var.environment
#   source     = "./modules/networking"
#   depends_on = [module.vpc, module.sg]

#   environment = each.key
#   cidr_block  = each.value.cidr_block
# }

# ## Create Jenkins Instances
# module "jenkins-instances" {
#   for_each   = var.environment
#   source     = "./modules/jenkins-instances"
#   depends_on = [module.networking, module.sg]

#   environment          = each.key
#   ami                  = each.value.ami
#   instance_type        = each.value.instance_type
#   initial_ssh_key_name = var.initial_ssh_key_name
# }