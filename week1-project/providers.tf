terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  # Backend resources are provisioned first from the backend/ directory.
  # Replace bucket_name with the actual value output by `terraform apply` in backend/.
  # backend "s3" {
  #   bucket         = "REPLACE_WITH_BACKEND_S3_BUCKET_NAME"
  #   key            = "wk1-project/terraform.tfstate"
  #   region         = "us-east-1"
  #   dynamodb_table = "hug-terraform-challenge-state-lock"
  #   encrypt        = true
  # }
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Project     = var.project_name
      Environment = var.environment
      ManagedBy   = "terraform"
    }
  }
}
