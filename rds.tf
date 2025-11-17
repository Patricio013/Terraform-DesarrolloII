resource "aws_db_subnet_group" "this" {
  count      = var.create_network ? 1 : 0
  name       = "${var.project}-dbsubnets"
  subnet_ids = local.selected_public_subnet_ids
  tags       = { Name = "${var.project}-dbsubnets" }
}

locals {
  db_subnet_group_effective = var.create_network ? aws_db_subnet_group.this[0].name : var.db_subnet_group_name

  rds_common = {
    engine                       = "postgres"
    engine_version               = "17.4"
    instance_class               = var.db_instance_class
    allocated_storage            = var.db_allocated_storage
    db_subnet_group_name         = local.db_subnet_group_effective
    vpc_security_group_ids       = [aws_security_group.rds_public.id]
    publicly_accessible          = true
    skip_final_snapshot          = true
    monitoring_interval          = var.rds_monitoring_interval
    # monitoring_role_arn solo si hay monitoring
    monitoring_role_arn          = var.rds_monitoring_interval == 0 ? null : (var.rds_monitoring_role_arn != "" ? var.rds_monitoring_role_arn : null)
    performance_insights_enabled = var.rds_pi_enabled
    storage_encrypted            = var.rds_storage_encrypted
  }
}

# PROD
resource "aws_db_instance" "prod" {
  identifier = "arreglaya-db"
  username   = var.db_username
  db_name    = var.db_prod_name
  password   = local.prod_db_password_value

  engine                       = local.rds_common.engine
  engine_version               = local.rds_common.engine_version
  instance_class               = local.rds_common.instance_class
  allocated_storage            = local.rds_common.allocated_storage
  db_subnet_group_name         = local.rds_common.db_subnet_group_name
  vpc_security_group_ids       = local.rds_common.vpc_security_group_ids
  publicly_accessible          = local.rds_common.publicly_accessible
  skip_final_snapshot          = local.rds_common.skip_final_snapshot
  monitoring_interval          = local.rds_common.monitoring_interval
  monitoring_role_arn          = local.rds_common.monitoring_role_arn
  performance_insights_enabled = local.rds_common.performance_insights_enabled
  storage_encrypted            = local.rds_common.storage_encrypted

  storage_type = var.rds_prod_storage_type

  tags = { Name = "arreglaya-db" }

  lifecycle {
    ignore_changes = [
      password,
      option_group_name,
      parameter_group_name,
      ca_cert_identifier,
      backup_window,
      maintenance_window,
      performance_insights_kms_key_id,
    ]
  }
}

# STG
resource "aws_db_instance" "stg" {
  identifier = "arreglaya-stg-db"
  username   = var.db_username
  db_name    = var.db_stg_name
  password   = local.stg_db_password_value

  engine                       = local.rds_common.engine
  engine_version               = local.rds_common.engine_version
  instance_class               = local.rds_common.instance_class
  allocated_storage            = local.rds_common.allocated_storage
  db_subnet_group_name         = local.rds_common.db_subnet_group_name
  vpc_security_group_ids       = local.rds_common.vpc_security_group_ids
  publicly_accessible          = local.rds_common.publicly_accessible
  skip_final_snapshot          = local.rds_common.skip_final_snapshot
  monitoring_interval          = local.rds_common.monitoring_interval
  monitoring_role_arn          = local.rds_common.monitoring_role_arn
  performance_insights_enabled = local.rds_common.performance_insights_enabled
  storage_encrypted            = local.rds_common.storage_encrypted

  storage_type = var.rds_stg_storage_type

  tags = { Name = "arreglaya-stg-db" }

  lifecycle {
    ignore_changes = [
      password,
      option_group_name,
      parameter_group_name,
      ca_cert_identifier,
      backup_window,
      maintenance_window,
      performance_insights_kms_key_id,
    ]
  }
}