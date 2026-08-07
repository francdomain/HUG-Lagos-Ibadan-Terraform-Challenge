module "networking" {
  source = "./modules/networking"

  vpc_cidr                       = var.vpc_cidr
  enable_dns_support             = var.enable_dns_support
  enable_dns_hostnames           = var.enable_dns_hostnames
  public_subnet_cidrs            = var.public_subnet_cidrs
  private_subnet_cidrs           = var.private_subnet_cidrs
  availability_zones             = var.availability_zones
  map_public_ip_on_launch        = var.map_public_ip_on_launch
  public_route_destination_cidr  = var.public_route_destination_cidr
  private_route_destination_cidr = var.private_route_destination_cidr
  name_prefix                    = var.name_prefix
  environment                    = var.environment
}

module "security_group" {
  source = "./modules/security_group"

  vpc_id              = module.networking.vpc_id
  allowed_ssh_cidr    = var.allowed_ssh_cidr
  allowed_http_cidr   = var.allowed_http_cidr
  allowed_egress_cidr = var.allowed_egress_cidr
  db_port             = var.db_port
  name_prefix         = var.name_prefix
  environment         = var.environment
}

module "compute" {
  source = "./modules/compute"

  instance_type      = var.instance_type
  subnet_id          = module.networking.public_subnet_ids[0]
  security_group_ids = [module.security_group.web_security_group_id]
  key_name           = var.key_name
  public_key_path    = var.public_key_path
  user_full_name     = var.user_full_name
  ami_owner          = var.ami_owner
  ami_name_filter    = var.ami_name_filter
  name_prefix        = var.name_prefix
  environment        = var.environment
}

module "database" {
  source = "./modules/database"

  db_subnet_ids         = module.networking.private_subnet_ids
  db_security_group_ids = [module.security_group.db_security_group_id]

  db_engine                = var.db_engine
  db_engine_version        = var.db_engine_version
  db_instance_class        = var.db_instance_class
  db_allocated_storage     = var.db_allocated_storage
  db_storage_type          = var.db_storage_type
  db_storage_encrypted     = var.db_storage_encrypted
  db_max_allocated_storage = var.db_max_allocated_storage

  db_name     = var.db_name
  db_username = var.db_username
  db_password = var.db_password

  skip_final_snapshot     = var.db_skip_final_snapshot
  deletion_protection     = var.db_deletion_protection
  multi_az                = var.db_multi_az
  apply_immediately       = var.db_apply_immediately
  backup_retention_period = var.db_backup_retention_period

  name_prefix = var.name_prefix
  environment = var.environment
}
