resource "aws_db_subnet_group" "public_3az" {
  name       = "arreglaya-dbsubnets"
  subnet_ids = [aws_subnet.public_a.id, aws_subnet.public_b.id, aws_subnet.public_c.id]
  tags = { Name = "arreglaya-dbsubnets" }
}

locals {
  rds_common = {
    engine               = "postgres"
    engine_version       = "17.4"
    instance_class       = var.db_instance_class
    allocated_storage    = var.db_allocated_storage
    db_subnet_group_name = aws_db_subnet_group.public_3az.name
    vpc_security_group_ids = [aws_security_group.rds_public.id]
    publicly_accessible  = true
    skip_final_snapshot  = true
  }
}

# PRODUCCIÓN
resource "aws_db_instance" "prod" {
  identifier = "arreglaya-db"
  username   = var.db_username
  password   = var.db_prod_password
  db_name    = var.db_prod_name

  # comunes
  engine               = local.rds_common.engine
  engine_version       = local.rds_common.engine_version
  instance_class       = local.rds_common.instance_class
  allocated_storage    = local.rds_common.allocated_storage
  db_subnet_group_name = local.rds_common.db_subnet_group_name
  vpc_security_group_ids = local.rds_common.vpc_security_group_ids
  publicly_accessible  = local.rds_common.publicly_accessible
  skip_final_snapshot  = local.rds_common.skip_final_snapshot
  tags = { Name = "arreglaya-db" }
}

# PRUEBA
resource "aws_db_instance" "stg" {
  identifier = "arreglaya-stg-db"
  username   = var.db_username
  password   = var.db_stg_password
  db_name    = var.db_stg_name

  # comunes
  engine               = local.rds_common.engine
  engine_version       = local.rds_common.engine_version
  instance_class       = local.rds_common.instance_class
  allocated_storage    = local.rds_common.allocated_storage
  db_subnet_group_name = local.rds_common.db_subnet_group_name
  vpc_security_group_ids = local.rds_common.vpc_security_group_ids
  publicly_accessible  = local.rds_common.publicly_accessible
  skip_final_snapshot  = local.rds_common.skip_final_snapshot
  tags = { Name = "arreglaya-stg-db" }
}