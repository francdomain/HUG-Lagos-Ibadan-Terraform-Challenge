variable "vpc_id" {
  description = "ID of the VPC where the security groups will be created"
  type        = string
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
  description = "Additional tags to apply to the security groups"
  type        = map(string)
  default     = {}
}
