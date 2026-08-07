terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket         = "hug-terraform-challenge-wk3-state-374171135764"
    key     = "wk3-project/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "hug-terraform-challenge-wk3-state-lock"
    encrypt = true
  }
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
