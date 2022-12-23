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



###Set permisions for Acess Control List (ACL)

resource "aws_s3_bucket_acl" "test" {
  bucket = aws_s3_bucket.test.id
  acl    = "private"
}




##Server Side Encryption with AWS_MANAGED KEY
resource "aws_s3_bucket_server_side_encryption_configuration" "shina-odukoya-encrypt" {
  bucket = aws_s3_bucket.test.id

    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

##KMS encryption
resource "aws_kms_key" "demokey" {
  description             = "key to encrypt bucket objects"
  deletion_window_in_days = 7
}

resource "aws_s3_bucket_server_side_encryption_configuration" "kms-shina-odukoya-encrypt" {
  bucket = aws_s3_bucket.test.id

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.demokey.arn
      sse_algorithm     = "aws:kms"
    }
  }
}

