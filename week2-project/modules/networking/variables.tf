variable "vpc_id" {
  description = "ID of the VPC where networking resources will be created"
  type        = string
}

variable "public_subnet_cidr" {
  description = "CIDR block for the public subnet"
  type        = string
}

variable "availability_zone" {
  description = "Availability zone for the public subnet"
  type        = string
  default     = "us-east-1a"
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
