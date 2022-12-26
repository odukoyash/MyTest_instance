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


###bucket versioning

resource "aws_s3_bucket_versioning" "test" {
  bucket = aws_s3_bucket.test.id
  versioning_configuration {
      status = "Enabled"
   }
}


#Enable Website Hosting
resource "aws_s3_bucket_website_configuration" "shina-odukoya-static-website" {
  bucket = aws_s3_bucket.test.bucket

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }

}


##Bucket replication

resource "aws_iam_role" "replication" {
  name = "bucket-rep-role"
  description ="Allow S3 to assume role for replication"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "s3.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": "s3ReplicationAssume"
    }
  ]
}
POLICY
}
#Creating a policy
resource "aws_iam_policy" "replication-policy" {
  name = "s3-bucket-replication-policy"

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:GetReplicationConfiguration",
        "s3:ListBucket"
      ],
      "Effect": "Allow",
      "Resource": [
        "${aws_s3_bucket.test.arn}"
      ]
    },
    {
      "Action": [
        "s3:GetObjectVersionForReplication",
        "s3:GetObjectVersionAcl",
         "s3:GetObjectVersionTagging"
      ],
      "Effect": "Allow",
      "Resource": [
        "${aws_s3_bucket.test.arn}/*"
      ]
    },
    {
      "Action": [
        "s3:ReplicateObject",
        "s3:ReplicateDelete",
        "s3:ReplicateTags"
      ],
      "Effect": "Allow",
      "Resource": "arn:aws:s3:::shina-test-stack-replication/*"
    }
  ]
}
POLICY
}
#Attaching the above created policy to the above created role
resource "aws_iam_role_policy_attachment" "replication" {
  role       = aws_iam_role.replication.name
  policy_arn = aws_iam_policy.replication-policy.arn
}



#bucket lifescyle to a different storage tiers

resource "aws_s3_bucket_intelligent_tiering_configuration" "tier-buck" {
  bucket = aws_s3_bucket.test.id
  name   = "tier-buck"


  tiering {
    access_tier = "DEEP_ARCHIVE_ACCESS"
    days        = 180
  }
  tiering {
    access_tier = "ARCHIVE_ACCESS"
    days        = 125
  }
}

