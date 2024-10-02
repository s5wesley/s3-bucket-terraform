resource "aws_s3_bucket" "my_bucket" {
  bucket = var.bucket_name
  acl    = var.bucket_acl

  versioning {
    enabled = true
  }

  replication_configuration {
    role = aws_iam_role.replication_role.arn

    rules {
      id     = "replicate"
      status = "Enabled"

      destination {
        bucket        = aws_s3_bucket.replica.arn
        storage_class = "STANDARD"
      }
    }
  }

  tags = {
    Name        = var.bucket_name
    Environment = var.environment
  }
}

resource "aws_s3_bucket" "replica" {
  bucket = var.replica_bucket_name
  acl    = var.bucket_acl

  versioning {
    enabled = true
  }

  tags = {
    Name        = var.replica_bucket_name
    Environment = var.environment
  }
}

resource "aws_iam_role" "replication_role" {
  name = "s3-replication-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "s3.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy" "replication_policy" {
  role = aws_iam_role.replication_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "s3:GetObjectVersionForReplication",
          "s3:GetObjectVersionAcl",
          "s3:GetObjectVersionTagging",
          "s3:ListBucket"
        ]
        Effect = "Allow"
        Resource = [
          aws_s3_bucket.my_bucket.arn,
          "${aws_s3_bucket.my_bucket.arn}/*"
        ]
      },
      {
        Action = "s3:ReplicateObject"
        Effect = "Allow"
        Resource = [
          aws_s3_bucket.replica.arn,
          "${aws_s3_bucket.replica.arn}/*"
        ]
      }
    ]
  })
}
