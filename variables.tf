variable "aws_region" {
  description = "The AWS region to deploy resources in"
  default     = "us-east-1"
}

variable "aws_profile" {
  description = "AWS CLI profile to use for authentication"
  default     = "default"
}

variable "bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
}

variable "replica_region" {
  description = "The region for the S3 replication"
  default     = "us-west-2"
}

variable "replica_bucket_name" {
  description = "The name of the S3 replica bucket"
  type        = string
}

variable "bucket_acl" {
  description = "The ACL to apply to the S3 bucket"
  type        = string
  default     = "private"
}

variable "environment" {
  description = "The environment for the bucket (e.g., Dev, Prod)"
  type        = string
  default     = "Dev"
}

variable "key_name" {
  description = "The AWS key name for EC2 instances"
  default     = "terraform"
}
