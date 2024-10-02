terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"  # Specify the desired AWS provider version
    }
  }

  backend "s3" {
    bucket         = "s5wesley_bucket"
    key            = "terraform/state/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "terraform-lock"
  }
}

provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile
}
