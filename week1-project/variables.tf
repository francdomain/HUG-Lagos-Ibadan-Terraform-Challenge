variable "aws_region" {
  description = "AWS region to deploy resources into"
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"
}

variable "user_full_name" {
  description = "Full name displayed on the challenge web page"
  type        = string
}

variable "key_name" {
  description = "Name of an existing AWS EC2 key pair for SSH access. Set to null when using public_key_path."
  type        = string
  default     = null
}

variable "public_key_path" {
  description = "Path to a local SSH public key to inject into the instance's authorized_keys"
  type        = string
  default     = null
}

variable "instance_type" {
  description = "EC2 instance type (t2.micro is free-tier eligible)"
  type        = string
  default     = "t2.micro"
}

variable "name_prefix" {
  description = "Prefix used for AWS resource names and tags"
  type        = string
  default     = "hug"
}

variable "project_name" {
  description = "Project name applied as a default resource tag"
  type        = string
  default     = "hug-terraform-challenge"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  description = "CIDR block for the public subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "availability_zone" {
  description = "Availability zone for the public subnet. Defaults to the first available zone."
  type        = string
  default     = null
}

variable "enable_dns_support" {
  description = "Enable DNS support in the VPC"
  type        = bool
  default     = true
}

variable "enable_dns_hostnames" {
  description = "Enable DNS hostnames in the VPC"
  type        = bool
  default     = true
}

variable "map_public_ip_on_launch" {
  description = "Assign public IP addresses to instances launched in the public subnet"
  type        = bool
  default     = true
}

variable "public_route_destination_cidr" {
  description = "Destination CIDR for the public route to the Internet Gateway"
  type        = string
  default     = "0.0.0.0/0"
}

variable "allowed_ssh_cidr" {
  description = "CIDR block allowed to connect via SSH"
  type        = string
  default     = "0.0.0.0/0"
}

variable "allowed_http_cidr" {
  description = "CIDR block allowed to connect via HTTP"
  type        = string
  default     = "0.0.0.0/0"
}

variable "allowed_egress_cidr" {
  description = "CIDR block allowed for all outbound traffic"
  type        = string
  default     = "0.0.0.0/0"
}

variable "ami_owner" {
  description = "AWS account ID (owner) of the AMI"
  type        = string
  default     = "099720109477" # Canonical
}

variable "ami_name_filter" {
  description = "Name filter used to look up the AMI"
  type        = string
  default     = "ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"
}
