provider "aws" {
  region     = var.AWS_REGION
  access_key = var.AWS_ACCESS_KEY
  secret_key = var.AWS_SECRET_KEY



  #assuming role
  assume_role {
    #role arn for stack terraform to assume to get access to Development account
    role_arn = "arn:aws:iam::349108081578:role/Engineering"
  }
}
