variable "env" { type = string }  # "stg" | "prod"

variable "aws_region" {
  type    = string
  default = "us-east-2"
}

# Red existente
variable "vpc_cidr"        { 
  type = string
  default = "172.31.0.0/16" 
}
variable "subnet_a_cidr"   { 
  type = string 
  default = "172.31.0.0/20" 
}   # us-east-2a
variable "subnet_b_cidr"   { 
  type = string
  default = "172.31.16.0/20" 
}  # us-east-2b
variable "subnet_c_cidr"   { 
  type = string
  default = "172.31.32.0/20" 
}  # us-east-2c

# Nombres base
variable "project" { 
  type = string
  default = "arreglaya" 
}

# Imágenes (ECR)
variable "backend_repo_name"  { 
  type = string
  default = "arreglaya-backend-stg" 
}
variable "frontend_repo_name" { 
  type = string
  default = "arreglaya-frontend-stg" 
}
variable "image_tag" { 
  type = string
  default = "latest" 
}

# RDS (prod y stg)
variable "db_username"         { 
  type = string
  default = "postgres" 
}
variable "db_prod_name"        { 
  type = string 
  default = "ArreglaYaBackend" 
}
variable "db_stg_name"         { 
  type = string 
  default = "postgres" 
}
variable "db_prod_password"    { 
  type = string 
  sensitive = true 
}
variable "db_stg_password"     { 
  type = string 
  sensitive = true 
}
variable "db_instance_class"   { 
  type = string 
  default = "db.t4g.micro" 
}
variable "db_allocated_storage"{ 
  type = number 
  default = 20 
}

# Backend app env
variable "spring_profile" { 
  type = string
  default = "stg" 
}

############################
# ECR repo names
############################
variable "ecr_backend_prod_repo_name"  { 
  type = string
  default = "arreglaya-backend-matching-y-agenda" 
}
variable "ecr_frontend_prod_repo_name" { 
  type = string
  default = "arreglaya-frontend-matching-y-agenda" 
}
variable "ecr_backend_stg_repo_name" { 
  type = string 
  default = "arreglaya-backend-stg" 
}
variable "ecr_frontend_stg_repo_name" { 
  type = string
  default = "arreglaya-frontend-stg" 
}

variable "image_tag_prod" { 
  type = string
  default = "latest" 
}
variable "image_tag_stg" { 
  type = string
  default = "latest" 
}

############################
# CPU/Mem por env (ajusta si difieren)
############################
variable "be_prod_cpu"     { 
  type = number
  default = 256 
}
variable "be_prod_memory"  { 
  type = number 
  default = 512 
}
variable "fe_prod_cpu"     { 
  type = number
  default = 256 
}
variable "fe_prod_memory"  { 
  type = number
  default = 512 
}

variable "be_stg_cpu"      { 
  type = number
  default = 256 
}
variable "be_stg_memory"   { 
  type = number
  default = 512 
}
variable "fe_stg_cpu"      { 
  type = number
  default = 1024 
}
variable "fe_stg_memory"   { 
  type = number 
  default = 3072 
}

############################
# Nombres de contenedores (como en tus tasks)
############################
variable "be_prod_container_name" { 
  type = string
  default = "backend" 
}
variable "fe_prod_container_name" { 
  type = string
  default = "frontend" 
}
variable "be_stg_container_name"  { 
  type = string 
  default = "backend-stg" 
}
variable "fe_stg_container_name"  { 
  type = string
  default = "frontend-stg" 
}

############################
# Target Groups (los conectamos cuando creemos los ALB)
############################
variable "alb_backend_prod_tg_arn"  { 
  type = string
  default = "" 
}
variable "alb_frontend_prod_tg_arn" { 
  type = string 
  default = "" 
}
variable "alb_backend_stg_tg_arn"   { 
  type = string
  default = "" 
}
variable "alb_frontend_stg_tg_arn"  { 
  type = string
  default = "" 
}