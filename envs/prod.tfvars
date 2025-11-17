image_tag_prod = "latest"

env = "prod"

vpc_id            = "vpc-093eeb1e761b09607"
public_subnet_ids = ["subnet-04cb5314296a2b7a2", "subnet-080c5993db667f034", "subnet-08961289559a751f8"]
alb_sg_id         = "sg-00cf8cd37a34e79d6"

# repos PROD
ecr_backend_prod_repo_name  = "arreglaya-backend-matching-y-agenda"
ecr_frontend_prod_repo_name = "arreglaya-frontend-matching-y-agenda"

# tamaños PROD
be_prod_cpu    = 256
be_prod_memory = 512
fe_prod_cpu    = 256
fe_prod_memory = 512
ecs_platform_version_prod = "LATEST"

# nombres de contenedor PROD
be_prod_container_name = "backend"
fe_prod_container_name = "frontend"

# TGs del ALB-PROD
alb_backend_prod_tg_arn  = "<output de tg_prod_backend_arn>"
alb_frontend_prod_tg_arn = "<output de tg_prod_frontend_arn>"

db_subnet_group_name = "default-vpc-093eeb1e761b09607"
ecs_services_sg_id = "sg-0dc2eb9a280a0f01d"