###Here I will be creating an S3 bucket
resource "aws_s3_bucket" "test" {
  bucket        = "stack-terraform-december-2022"
  tags		={Environment:	"Development"}
}


#Enabling Server Access Logging

resource "aws_s3_bucket" "log_bucket" {
  bucket = "stack-terraform-december-2022"
}

resource "aws_s3_bucket_acl" "log_bucket_acl" {
  bucket = aws_s3_bucket.log_bucket.id
  acl    = "log-delivery-write"
}

resource "aws_s3_bucket_logging" "example" {
  bucket = aws_s3_bucket.test.id

  target_bucket = aws_s3_bucket.log_bucket.id
  target_prefix = "log/"
}

