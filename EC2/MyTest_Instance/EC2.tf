locals{
  server_name="StackInstance"
  server_prefix="Stack"
  }

resource "aws_key_pair" "mytest_instance_kp" {
  key_name   = "mytest_instance_kp.pub"
  public_key = file(var.PATH_TO_PUBLIC_KEY)
}

resource "aws_instance" "MyTest_instance" {
  for_each                       = toset(data.aws_subnets.stack_sub_id_list.ids)
  ami                         = var.ami
  instance_type               = var.instance_type
  vpc_security_group_ids      = [aws_security_group.mytest_instance-sg.id]
  subnet_id                   = each.key
  #user_data                   = data.template_file.bootstrap.rendered
  key_name = aws_key_pair.mytest_instance_kp.key_name

  root_block_device {
    volume_type               = "gp2"
    volume_size               = 20
    delete_on_termination     = true
    encrypted= "false"
  }
  tags                        = {
        Name                        = "${local.server_name!=""? local.server_name : "Mytest_Instance$_{each.key}"}"
        OwnerEmail                  = "shinaodukoya@usa.com"
        StactTeam                   = "stackcloud9"
        Schedule                    = "A"
        Backup                      = "Yes"
    }
}