output "bucket_name" {
  description = "The name of the S3 bucket"
  value       = aws_s3_bucket.my_bucket.bucket
}

output "bucket_region" {
  description = "The AWS region where the bucket is created"
  value       = var.aws_region
}

output "replica_bucket_name" {
  description = "The name of the S3 replica bucket"
  value       = aws_s3_bucket.replica.bucket
}

output "bucket_arn" {
  description = "The ARN of the S3 bucket"
  value       = aws_s3_bucket.my_bucket.arn
}

output "replica_bucket_arn" {
  description = "The ARN of the S3 replica bucket"
  value       = aws_s3_bucket.replica.arn
}
