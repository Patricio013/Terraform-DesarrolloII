# Secrets (contenedores)
resource "aws_secretsmanager_secret" "db_prod_password" {
  name        = "arreglaya/prod/db_password"
  description = "DB password PROD"
}

resource "aws_secretsmanager_secret" "db_stg_password" {
  name        = "arreglaya/stg/db_password"
  description = "DB password STG"
}

# Passwords: usa la provista o genera una válida para RDS
# Reglas RDS: 8-128 chars, ASCII imprimible; no uses "/" ni "@" ni comillas dobles.
resource "random_password" "db_prod" {
  length           = 24
  special          = true
}
resource "random_password" "db_stg" {
  length           = 24
  special          = true
}

locals {
  prod_db_password_value = var.db_prod_password != "" ? var.db_prod_password : random_password.db_prod.result
  stg_db_password_value  = var.db_stg_password  != "" ? var.db_stg_password  : random_password.db_stg.result
}

# Versiones (contenido) de los secrets
resource "aws_secretsmanager_secret_version" "db_prod_password" {
  secret_id     = aws_secretsmanager_secret.db_prod_password.id
  secret_string = local.prod_db_password_value
}

resource "aws_secretsmanager_secret_version" "db_stg_password" {
  secret_id     = aws_secretsmanager_secret.db_stg_password.id
  secret_string = local.stg_db_password_value
}