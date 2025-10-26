terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

# ## Create Security groups
# module "security-groups" {
#   source = "./../../modules/security"
#   #   depends_on                    = [module.vpc]
#   environment                   = var.environment
#   ssh-allowed-inbound-subnets   = var.ssh-allowed-inbound-subnets
#   https-allowed-inbound-subnets = var.https-allowed-inbound-subnets
# }

# Create Environment networks
module "networking" {
  source = "./../../modules/networking"

  vpc_id = data.aws_vpc.kama_build.id
  environment = var.environment
  cidr_block  = var.cidr_block
}

# Security groups
## Inbound traffic
module "inbound-security-groups" {
  for_each = var.inbound_allowed_traffic
  source   = "./../../modules/security"

  inbound_traffic = true
  # outbound_traffic = true
  vpc_id = data.aws_vpc.kama_build.id
  environment = var.environment
  description = each.key
  from_port   = each.value.from_port
  to_port     = each.value.to_port
  protocol    = each.value.protocol
  cidr_blocks = each.value.cidr_blocks
}

## Outbound traffic
module "outbound-security-groups" {
  for_each = var.outbound_allowed_traffic
  source   = "./../../modules/security"

  outbound_traffic = true
  vpc_id = data.aws_vpc.kama_build.id
  environment = var.environment
  description = each.key
  from_port   = each.value.from_port
  to_port     = each.value.to_port
  protocol    = each.value.protocol
  cidr_blocks = each.value.cidr_blocks
}

# Create block storage
resource "aws_ebs_volume" "package_volume" {
  availability_zone = var.region
  size              = var.packages_disk_volume

   tags = {
    Name        = "${var.environment}-package_volume"
    Environment = "${var.environment}"
  }
  lifecycle {
   prevent_destroy = true
 }
}

# Create Jenkins Instances
module "jenkins-instances" {
  source = "./../../modules/jenkins-instances"

  environment                = var.environment
  ami                        = var.ami
  instance_type              = var.instance_type
  initial_ssh_key_name       = var.initial_ssh_key_name
  subnet_id                  = module.networking.subnet_id
  inbound_security_group_ids = [for sg in module.inbound-security-groups : sg.inbound_security_group_id]
  outbound_security_group_ids = [for sg in module.outbound-security-groups : sg.outbound_security_group_id]
}

# Attach package storage volume to instance
resource "aws_volume_attachment" "package_volume_to_jenkins" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.package_volume.id
  instance_id = module.jenkins-instances.jenkins-instance-id
  depends_on = [module.jenkins-instances]
}
