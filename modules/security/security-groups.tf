resource "aws_security_group" "inbound-traffic" {
  name_prefix = "${var.environment}-inbound-${var.description}"
  vpc_id      = var.vpc_id
  count = var.inbound_traffic ? 1 : 1 #Skip if supposed to build inbound traffic

  ingress {
    description = var.description
    from_port   = var.from_port
    to_port     = var.to_port
    protocol    = var.protocol
    cidr_blocks = var.cidr_blocks
  }
  tags = {
    Name        = "${var.environment}-inbound-security-group"
    Environment = "${var.environment}"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group" "outbound-traffic" {
  name_prefix = "${var.environment}-outbound-${var.description}"
  vpc_id      = var.vpc_id
  count = var.outbound_traffic ? 1 : 1 #Skip if supposed to build inbound traffic

  egress {
    description = var.description
    from_port   = var.from_port
    to_port     = var.to_port
    protocol    = var.protocol
    cidr_blocks = var.cidr_blocks
  }
  tags = {
    Name        = "${var.environment}-outbound-security-group"
    Environment = "${var.environment}"
  }

  lifecycle {
    create_before_destroy = true
  }
}


# resource "aws_security_group" "inbound-traffic" {
#   name_prefix = "${var.environment}"
#   vpc_id      = data.aws_vpc.main.id

#   ingress {
#     description = "SSH"
#     from_port   = 22
#     to_port     = 22
#     protocol    = "tcp"
#     cidr_blocks = var.ssh-allowed-inbound-subnets
#   }

#   ingress {
#     description = "HTTPS"
#     from_port   = 443
#     to_port     = 443
#     protocol    = "tcp"
#     cidr_blocks = var.https-allowed-inbound-subnets
#   }

# ## Just used for testing 
#   ingress {
#     description = "HTTP"
#     from_port   = 80
#     to_port     = 80
#     protocol    = "tcp"
#     cidr_blocks = var.https-allowed-inbound-subnets
#   }
# ##
#   egress {
#     description = "All outbound traffic"
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   tags = {
#     Name        = "${var.environment}-inbound-security-group"
#     Environment = "${var.environment}"
#   }

#   lifecycle {
#     create_before_destroy = true
#   }
# }

# resource "aws_security_group" "outbound-traffic" {
#   name_prefix = "${var.environment}"
#   vpc_id      = data.aws_vpc.main.id

#   egress {
#     description = "All outbound traffic"
#     from_port   = 0
#     to_port     = 0
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   egress {
#     description = "All outbound traffic"
#     from_port   = 0
#     to_port     = 0
#     protocol    = "udp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   tags = {
#     Name        = "${var.environment}-inbound-security-group"
#     Environment = "${var.environment}"
#   }

#   lifecycle {
#     create_before_destroy = true
#   }
# }

