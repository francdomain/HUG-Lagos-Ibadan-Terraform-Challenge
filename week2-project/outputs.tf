output "vpc_id" {
  description = "ID of the created VPC"
  value       = module.vpc.vpc_id
}

output "public_subnet_id" {
  description = "ID of the public subnet"
  value       = module.networking.public_subnet_id
}

output "security_group_id" {
  description = "ID of the web security group"
  value       = module.security_group.security_group_id
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
