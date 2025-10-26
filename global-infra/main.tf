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

  main_cidr_block = var.main_cidr_block
}

# Add the creation of volumes here
# Add the creation