data "aws_security_group" "web_sg" {
  filter {
    name   = "tag:Name"
    values = ["web-security-group"]
  }

}

data "aws_subnet" "environment_subnet" {
  filter {
    name   = "tag:Name"
    values = ["${var.environment}-subnet"]
  }
}