image_tag_prod = "latest"

# repos PROD (como en tus capturas)
ecr_backend_prod_repo_name  = "arreglaya-backend-matching-y-agenda"
ecr_frontend_prod_repo_name = "arreglaya-frontend-matching-y-agenda"

# tamaños PROD (ajústalo a lo real si difiere)
be_prod_cpu     = 256
be_prod_memory  = 512
fe_prod_cpu     = 256
fe_prod_memory  = 512

# nombres de contenedor PROD
be_prod_container_name = "backend"
fe_prod_container_name = "frontend"

# TGs del ALB-PROD (rellenar luego)
alb_backend_prod_tg_arn  = "<output de tg_prod_backend_arn>"
alb_frontend_prod_tg_arn = "<output de tg_prod_frontend_arn>"