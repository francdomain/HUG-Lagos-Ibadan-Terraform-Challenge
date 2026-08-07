variable "instance_type" {
  description = "EC2 instance type (t2.micro is free-tier eligible)"
  type        = string
  default     = "t2.micro"
}

variable "subnet_id" {
  description = "ID of the public subnet where the instance will be launched"
  type        = string
}

variable "security_group_ids" {
  description = "List of security group IDs to attach to the instance"
  type        = list(string)
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

variable "user_full_name" {
  description = "Full name displayed on the challenge web page"
  type        = string
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

variable "name_prefix" {
  description = "Prefix used for resource names and tags"
  type        = string
  default     = "hug"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"
}

variable "tags" {
  description = "Additional tags to apply to the EC2 instance"
  type        = map(string)
  default     = {}
}
