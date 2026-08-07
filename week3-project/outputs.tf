output "vpc_id" {
  description = "ID of the created VPC"
  value       = module.networking.vpc_id
}

output "public_subnet_ids" {
  description = "IDs of the public subnets"
  value       = module.networking.public_subnet_ids
}

output "private_subnet_ids" {
  description = "IDs of the private subnets"
  value       = module.networking.private_subnet_ids
}

output "web_security_group_id" {
  description = "ID of the web server security group"
  value       = module.security_group.web_security_group_id
}

output "db_security_group_id" {
  description = "ID of the database security group"
  value       = module.security_group.db_security_group_id
}

output "instance_id" {
  description = "ID of the EC2 instance"
  value       = module.compute.instance_id
}

output "instance_public_ip" {
  description = "Public IP of the web server"
  value       = module.compute.instance_public_ip
}

output "website_url" {
  description = "Direct link to the Nginx landing page"
  value       = module.compute.website_url
}

output "db_instance_id" {
  description = "ID of the RDS database instance"
  value       = module.database.db_instance_id
}

output "db_instance_endpoint" {
  description = "Connection endpoint of the RDS database instance"
  value       = module.database.db_instance_endpoint
  sensitive   = true
}

output "db_instance_address" {
  description = "Address of the RDS database instance"
  value       = module.database.db_instance_address
}

output "db_instance_port" {
  description = "Port of the RDS database instance"
  value       = module.database.db_instance_port
}
