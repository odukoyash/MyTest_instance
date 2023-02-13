resource "aws_security_group" "mytest_instance-sg" {
  vpc_id      = var.vpc_id
  name        = "Mytest_instance-WebDMZ"
  description = "Mytest_instance Security Group"
}
#Add rule to SSH into EC2 instance
resource "aws_security_group_rule" "ssh" {
  security_group_id = aws_security_group.mytest_instance-sg.id
  type              = "ingress"
  protocol          = "tcp"
  from_port         = 22
  to_port           = 22
  cidr_blocks       = ["0.0.0.0/0"]
}
resource "aws_security_group_rule" "egress-rule" {
  security_group_id = aws_security_group.mytest_instance-sg.id
  type              = "egress"
  protocol          = "-1"
  from_port         = 0
  to_port           = 0
  cidr_blocks       = ["0.0.0.0/0"]
}

#Add rule to SSH into EC2 instance
resource "aws_security_group_rule" "http-rule" {
  security_group_id = aws_security_group.mytest_instance-sg.id
  type              = "ingress"
  protocol          = "tcp"
  from_port         = 80
  to_port           = 80
  cidr_blocks       = ["0.0.0.0/0"]
}
