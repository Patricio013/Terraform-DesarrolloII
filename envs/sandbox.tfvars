# sandbox: crear todo
env              = "sandbox"
aws_region       = "us-east-2"
create_network   = true

# NO pases vpc_id/public_subnet_ids/alb_sg_id — se crean.
vpc_id            = ""
public_subnet_ids = []
alb_sg_id         = ""

# ECR repos sandbox
ecr_backend_stg_repo_name  = "arreglaya-backend-stg"
ecr_frontend_stg_repo_name = "arreglaya-frontend-stg"
ecr_backend_prod_repo_name  = "arreglaya-backend-matching-y-agenda"
ecr_frontend_prod_repo_name = "arreglaya-frontend-matching-y-agenda"

# tamaños pequeños para sandbox
be_prod_cpu    = 256
be_prod_memory = 512
fe_prod_cpu    = 256
fe_prod_memory = 512

be_stg_cpu     = 256
be_stg_memory  = 512
fe_stg_cpu     = 256
fe_stg_memory  = 512

# imágenes
image_tag_prod = "latest"
image_tag_stg  = "latest"

# nombres de contenedor
be_prod_container_name = "backend"
fe_prod_container_name = "frontend"
be_stg_container_name  = "backend-stg"
fe_stg_container_name  = "frontend-stg"

db_subnet_group_name     = ""
rds_monitoring_interval  = 0 
rds_monitoring_role_arn  = ""