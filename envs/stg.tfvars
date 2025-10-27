image_tag_stg = "latest"

# recursos ECR (nombres iguales a tus repos)
ecr_backend_stg_repo_name  = "arreglaya-backend-stg"
ecr_frontend_stg_repo_name = "arreglaya-frontend-stg"

# tamaños STG (según pantallas)
be_stg_cpu     = 256
be_stg_memory  = 512
fe_stg_cpu     = 1024
fe_stg_memory  = 3072

# nombres de contenedor STG
be_stg_container_name = "backend-stg"
fe_stg_container_name = "frontend-stg"

# TGs del ALB-STG (rellenar luego del paso ALB)
alb_backend_stg_tg_arn  = "<output de tg_stg_backend_arn>"
alb_frontend_stg_tg_arn = "<output de tg_stg_frontend_arn>"