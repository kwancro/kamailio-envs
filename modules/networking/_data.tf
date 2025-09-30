data "aws_vpc" "main" {
  filter {
    name   = "tag:Name"
    values = ["main-vpc"]
  }
}

data "aws_route_table" "public" {
  filter {
    name   = "tag:Name"
    values = ["main-public-rt"]
  }
}

data "aws_security_group" "web_sg" {
  filter {
    name   = "tag:Name"
    values = ["web-security-group"]
  }

}