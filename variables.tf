variable "env" { type = string }  # "stg" | "prod" | "sandbox"

variable "aws_region" {
  type    = string
  default = "us-east-2"
}

# RED EXISTENTE o NUEVA
variable "create_network" {
  type        = bool
  default     = false
  description = "true = Terraform crea VPC/subnets; false = usa red existente."
}

variable "vpc_id" {
  type        = string
  default     = ""
  description = "ID de VPC existente (si create_network=false)."
}

variable "public_subnet_ids" {
  type        = list(string)
  default     = []
  description = "IDs de subnets públicas existentes (si create_network=false)."
}

variable "alb_sg_id" {
  type        = string
  default     = ""
  description = "SG existente del ALB (si create_network=false)."
}

# Datos de la red cuando se crea
variable "vpc_cidr"        { 
  type = string
  default = "172.31.0.0/16" 
}
variable "subnet_a_cidr"   { 
  type = string
  default = "172.31.0.0/20" 
}
variable "subnet_b_cidr"   { 
  type = string
  default = "172.31.16.0/20" 
}
variable "subnet_c_cidr"   { 
  type = string
  default = "172.31.32.0/20" 
}

# Nombres base
variable "project" { 
  type = string
  default = "arreglaya" 
}

# Repos ECR
variable "ecr_backend_prod_repo_name"  { 
  type = string 
  default = "arreglaya-backend-matching-y-agenda" 
  }
variable "ecr_frontend_prod_repo_name" { 
  type = string
  default = "arreglaya-frontend-matching-y-agenda" 
  }
variable "ecr_backend_stg_repo_name"   { 
  type = string
  default = "arreglaya-backend-stg" 
  }
variable "ecr_frontend_stg_repo_name"  { 
  type = string
  default = "arreglaya-frontend-stg" 
  }

# Tags de imagen
variable "image_tag_prod" { 
  type = string
  default = "latest" 
  }
variable "image_tag_stg"  { 
  type = string
  default = "latest" 
  }

# RDS
variable "db_username"          { 
  type = string
  default = "postgres" 
  }
variable "db_prod_name"         { 
  type = string
  default = "ArreglaYaBackend" 
  }
variable "db_stg_name"          { 
  type = string
  default = "postgres" 
  }
variable "db_instance_class"    { 
  type = string
  default = "db.t4g.micro" 
  }
variable "db_allocated_storage" { 
  type = number
  default = 20 
  }

# RDS subnet group (si usás red existente)
variable "db_subnet_group_name" { 
  type = string
  default = "" 
}

# Enhanced Monitoring (desactivado por defecto para evitar pass-role)
variable "rds_monitoring_interval" { 
  type = number
  default = 0 
} 
variable "rds_monitoring_role_arn" { 
  type = string
  default = "" 
}

# Performance Insights / Encryption
variable "rds_pi_enabled"        { 
  type = bool
  default = true 
}
variable "rds_storage_encrypted" { 
  type = bool 
  default = true 
}

# Tipos de storage por entorno
variable "rds_prod_storage_type" { 
  type = string
  default = "gp2" 
  }

variable "rds_stg_storage_type"  { 
  type = string 
  default = "gp2" 
  }

# CPU/Mem por env
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

# Nombres contenedores
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

# Platform version ECS
variable "ecs_platform_version_prod" { 
  type = string
  default = "LATEST" 
}
variable "ecs_platform_version_stg"  { 
  type = string
  default = "LATEST" 
}

#Contraseña RDS
variable "db_prod_password" {
  type      = string
  sensitive = true
  default   = ""   # si queda vacío, se genera automáticamente
}
variable "db_stg_password" {
  type      = string
  sensitive = true
  default   = ""   # si queda vacío, se genera automáticamente
}