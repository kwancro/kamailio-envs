terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }

  backend "s3" {
    bucket         = "kamailio-build-env-state"
    key            = "production/terraform.tfstate"
    region         = "eu-west-1"
    dynamodb_table = "kamailio-build-env-locks"
    encrypt        = true
  }
}

## Create VPC
module "vpc" {
  source          = "./../../modules/vpc"
  vpc_name        = var.vpc_name
  main_cidr_block = var.main_cidr_block
  environment     = var.environment
}

# Create Environment networks
module "networking" {
  source = "./../../modules/networking"

  vpc_id         = module.vpc.vpc_id
  environment    = var.environment
  cidr_block     = var.cidr_block
  route_table_id = module.vpc.route_table_id
}
