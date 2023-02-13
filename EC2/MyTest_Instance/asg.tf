resource "aws_launch_configuration" "example" {
  image_id = "ami-08f3d892de259504d"
  instance_type = "t2.micro"
}

resource "aws_autoscaling_group" "example" {
  launch_configuration = aws_launch_configuration.example.name
  min_size = 1
  max_size = 3
  desired_capacity = 2
  vpc_zone_identifier = ["subnet-0fd12f64ef4477115"]
}