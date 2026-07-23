variable "aws_region" {
  description = "AWS region for the Terraform backend resources"
  type        = string
  default     = "us-east-1"
}

variable "bucket_name" {
  description = "Globally unique name for the S3 bucket that stores Terraform state"
  type        = string
}

variable "dynamodb_table_name" {
  description = "Name of the DynamoDB table used for state locking"
  type        = string
  default     = "hug-terraform-challenge-state-lock"
}

variable "environment" {
  description = "Environment name applied as a default resource tag"
  type        = string
  default     = "dev"
}

variable "project_name" {
  description = "Project name applied as a default resource tag"
  type        = string
  default     = "hug-terraform-challenge"
}
