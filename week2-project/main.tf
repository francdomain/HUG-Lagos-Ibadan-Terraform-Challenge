module "vpc" {
  source = "./modules/vpc"

  vpc_cidr             = var.vpc_cidr
  enable_dns_support   = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames
  name_prefix          = var.name_prefix
  environment          = var.environment
}

module "networking" {
  source = "./modules/networking"

  vpc_id                        = module.vpc.vpc_id
  public_subnet_cidr            = var.public_subnet_cidr
  availability_zone             = var.availability_zone
  map_public_ip_on_launch       = var.map_public_ip_on_launch
  public_route_destination_cidr = var.public_route_destination_cidr
  name_prefix                   = var.name_prefix
  environment                   = var.environment
}

module "security_group" {
  source = "./modules/security_group"

  vpc_id              = module.vpc.vpc_id
  allowed_ssh_cidr    = var.allowed_ssh_cidr
  allowed_http_cidr   = var.allowed_http_cidr
  allowed_egress_cidr = var.allowed_egress_cidr
  name_prefix         = var.name_prefix
  environment         = var.environment
}

module "compute" {
  source = "./modules/compute"

  instance_type      = var.instance_type
  subnet_id          = module.networking.public_subnet_id
  security_group_ids = [module.security_group.security_group_id]
  key_name           = var.key_name
  public_key_path    = var.public_key_path
  user_full_name     = var.user_full_name
  ami_owner          = var.ami_owner
  ami_name_filter    = var.ami_name_filter
  name_prefix        = var.name_prefix
  environment        = var.environment
}
