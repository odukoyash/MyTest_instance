resource "aws_ebs_volume" "example" {
  availability_zone = "us-east-1a"
  size              = 50
}
