variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
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

variable "public_subnet_cidrs" {
  description = "CIDR blocks for the public subnets"
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "CIDR blocks for the private subnets"
  type        = list(string)
}

variable "availability_zones" {
  description = "Availability zones for the subnets"
  type        = list(string)
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
  description = "Additional tags to apply to networking resources"
  type        = map(string)
  default     = {}
}
