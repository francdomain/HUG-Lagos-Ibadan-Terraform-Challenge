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

variable "public_subnet_cidrs" {
  description = "CIDR blocks for the public subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidrs" {
  description = "CIDR blocks for the private subnets"
  type        = list(string)
  default     = ["10.0.3.0/24", "10.0.4.0/24"]
}

variable "availability_zones" {
  description = "Availability zones for the subnets"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
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
  description = "Assign public IP addresses to instances launched in public subnets"
  type        = bool
  default     = true
}

variable "public_route_destination_cidr" {
  description = "Destination CIDR for the public route to the Internet Gateway"
  type        = string
  default     = "0.0.0.0/0"
}

variable "private_route_destination_cidr" {
  description = "Destination CIDR for the private route to the NAT Gateway"
  type        = string
  default     = "0.0.0.0/0"
}

variable "allowed_ssh_cidr" {
  description = "CIDR block allowed to connect via SSH (set to your own IP address)"
  type        = string
}

variable "allowed_http_cidr" {
  description = "CIDR block allowed to connect via HTTP"
  type        = string
  default     = "0.0.0.0/0"
}

variable "allowed_egress_cidr" {
  description = "CIDR block allowed for all outbound traffic from the web server"
  type        = string
  default     = "0.0.0.0/0"
}

variable "db_port" {
  description = "Port used by the database engine"
  type        = number
  default     = 3306
}

variable "db_engine" {
  description = "Database engine"
  type        = string
  default     = "mysql"
}

variable "db_engine_version" {
  description = "Database engine version"
  type        = string
  default     = "8.0"
}

variable "db_instance_class" {
  description = "Instance class for the database"
  type        = string
  default     = "db.t3.micro"
}

variable "db_allocated_storage" {
  description = "Allocated storage for the database in GB"
  type        = number
  default     = 20
}

variable "db_storage_type" {
  description = "Storage type for the database"
  type        = string
  default     = "gp2"
}

variable "db_storage_encrypted" {
  description = "Enable storage encryption"
  type        = bool
  default     = true
}

variable "db_max_allocated_storage" {
  description = "Maximum allocated storage for storage autoscaling (0 to disable)"
  type        = number
  default     = 0
}

variable "db_name" {
  description = "Name of the default database"
  type        = string
  default     = "hugdb"
}

variable "db_username" {
  description = "Master username for the database"
  type        = string
  default     = "admin"
}

variable "db_password" {
  description = "Master password for the database"
  type        = string
  sensitive   = true
}

variable "db_skip_final_snapshot" {
  description = "Skip final snapshot before deletion"
  type        = bool
  default     = true
}

variable "db_deletion_protection" {
  description = "Enable deletion protection"
  type        = bool
  default     = false
}

variable "db_multi_az" {
  description = "Enable Multi-AZ deployment"
  type        = bool
  default     = false
}

variable "db_apply_immediately" {
  description = "Apply database changes immediately"
  type        = bool
  default     = true
}

variable "db_backup_retention_period" {
  description = "Backup retention period in days"
  type        = number
  default     = 0
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
