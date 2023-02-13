resource "aws_alb" "MyTest_Instance" {
  name            = "MyTestInstance-alb"
  internal        = false
  security_groups = ["sg-0bf71880fe3650c0f"]
  subnets         = ["subnet-0fd12f64ef4477115", "subnet-06499a536ff6ac965"]
}
resource "aws_alb_target_group" "MyTest_Instance" {
  name = "MyTestInstance-target-group"
  port = "80"
  protocol = "HTTP"
  vpc_id = "vpc-0be6dc4ef116a2c1f"

  health_check {
    path = "/health"
    interval = 30
    timeout = 5
    healthy_threshold = 5
    unhealthy_threshold = 2
    matcher = "200-299"
  }
}
