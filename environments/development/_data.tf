data "aws_vpc" "kama_build" {
  filter {
    name   = "tag:Build_id"
    values = ["kama-build"]
  }
}