resource "aws_db_subnet_group" "main" {
  name        = "${var.name_prefix}-db-subnet-group"
  description = "Subnet group for the two-tier database"
  subnet_ids  = var.db_subnet_ids

  tags = merge(var.tags, {
    Name        = "${var.name_prefix}-db-subnet-group"
    Environment = var.environment
  })
}

resource "aws_db_instance" "main" {
  identifier     = "${var.name_prefix}-db"
  engine         = var.db_engine
  engine_version = var.db_engine_version
  instance_class = var.db_instance_class

  allocated_storage     = var.db_allocated_storage
  storage_type          = var.db_storage_type
  storage_encrypted     = var.db_storage_encrypted
  max_allocated_storage = var.db_max_allocated_storage > 0 ? var.db_max_allocated_storage : null

  db_name  = var.db_name
  username = var.db_username
  password = var.db_password

  db_subnet_group_name   = aws_db_subnet_group.main.name
  vpc_security_group_ids = var.db_security_group_ids

  publicly_accessible     = false
  skip_final_snapshot     = var.skip_final_snapshot
  deletion_protection     = var.deletion_protection
  multi_az                = var.multi_az
  apply_immediately       = var.apply_immediately
  backup_retention_period = var.backup_retention_period

  tags = merge(var.tags, {
    Name        = "${var.name_prefix}-db"
    Environment = var.environment
  })
}
