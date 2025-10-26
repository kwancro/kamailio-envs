resource "aws_instance" "instance" {
  ami                    = var.ami
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  vpc_security_group_ids = concat(var.inbound_security_group_ids, var.outbound_security_group_ids)
  key_name               = var.initial_ssh_key_name
  ## Used for testing
  user_data = <<-EOF
                #!/usr/bin/bash
                curl -fsSL https://get.docker.com -o get-docker.sh
                sh get-docker.sh
                docker run -d -p 80:80 --name iamfoo traefik/whoami
                EOF
  ##

  tags = {
    Name        = "${var.environment}-instance"
    Environment = var.environment
  }
}