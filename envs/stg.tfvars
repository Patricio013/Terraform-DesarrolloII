image_tag_stg = "latest"

env = "stg"

vpc_id            = "vpc-093eeb1e761b09607"
public_subnet_ids = ["subnet-04cb5314296a2b7a2", "subnet-080c5993db667f034", "subnet-08961289559a751f8"]
alb_sg_id         = "sg-00cf8cd37a34e79d6"

# recursos ECR
ecr_backend_stg_repo_name  = "arreglaya-backend-stg"
ecr_frontend_stg_repo_name = "arreglaya-frontend-stg"

# tamaños STG
be_stg_cpu    = 256
be_stg_memory = 512
fe_stg_cpu    = 1024
fe_stg_memory = 3072
ecs_platform_version_stg = "1.4.0"

# nombres de contenedor STG
be_stg_container_name = "backend-stg"
fe_stg_container_name = "frontend-stg"

# TGs del ALB-STG
alb_backend_stg_tg_arn  = "<output de tg_stg_backend_arn>"
alb_frontend_stg_tg_arn = "<output de tg_stg_frontend_arn>"

db_subnet_group_name = "default-vpc-093eeb1e761b09607"
ecs_services_sg_id = "sg-0dc2eb9a280a0f01d"