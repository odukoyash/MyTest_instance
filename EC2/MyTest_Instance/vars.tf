variable "AWS_ACCESS_KEY" {}

variable "AWS_SECRET_KEY" {}


variable "AWS_REGION" {
  default = "us-east-1"
}

variable "PATH_TO_PUBLIC_KEY" {
  default = "mytest_instance_kp.pub"
}

variable "AMIS" {
  type = map(string)
  default = {
    us-east-1 = "ami-08f3d892de259504d"
    us-west-2 = "ami-06b94666"
    eu-west-1 = "ami-844e0bf7"
  }
}

variable "subnets" {
  type = list(string)
  default = [
    "subnet-0fd12f64ef4477115",
    "subnet-06499a536ff6ac965",
  ]
}

variable "vpc_id" {
  default = "vpc-0be6dc4ef116a2c1f"
}
variable "instance_type" {
  default = "t2.small"
}

variable "ami" {
  default = "ami-08f3d892de259504d"
}

#auto scaling group
variable "instance_types" {
  type        = string
  description = "Instance type for the auto scaling group for MyTest_Instance"
  default     = "t2.micro"
}

variable "desired_capacity" {
  type        = number
  description = "The number of desired instances in the auto scaling grou for MyTest_Instance"
  default     = 1
}

variable "min_size" {
  type        = number
  description = "The minimum number of instances in the auto scaling group for MyTest_Instance"
  default     = 1
}

variable "max_size" {
  type        = number
  description = "The maximum number of instances in the auto scaling groufor MyTest_Instancep"
  default     = 3
}

#Creating Application Load Balancer
variable "MyTest_instance" {
  type        = string
  description = " Application Load Balancer For MyTest_Instance"
  default     = "MyTest_Instance-alb"
}

variable "alb_subnets" {
  type        = list(string)
  description = "Subnets for the Application Load Balancer"
  default     = ["subnet-01", "subnet-02", "subnet-03"]
}

#Creating EBS Volume
variable "ebs_volume_size" {
  type        = number
  description = "The size of the EBS volume in GiB"
}

variable "ebs_volume_az" {
  type        = string
  description = "The availability zone for the EBS volume"
}

#creating S3 bucket
variable "bucket_name" {
  type        = string
  description = "Name of the S3 bucket"
}

variable "region" {
  type        = string
  description = "AWS region to create the S3 bucket in"
  default     = "us-east-1"
}
