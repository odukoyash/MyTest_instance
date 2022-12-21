###Here I will be creating an S3 bucket
resource "aws_s3_bucket" "test" {
  bucket        = "stack-terraform-december-2022"
}
