data "template_file" "bootstrap" {
  template =("/c/apps/terraform/tf/EC2/MyTest_Instance/scripts/clixx_bootstrap.tpl")
  vars={
   Datadog_API_Key=23234333434534534345556565
  }
}

data "aws_subnets" "stack_sub_id_list" {
   filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }
}