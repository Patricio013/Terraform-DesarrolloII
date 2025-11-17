# RDS
output "rds_prod_endpoint" { value = aws_db_instance.prod.address }
output "rds_stg_endpoint"  { value = aws_db_instance.stg.address }

# ALB DNS
output "alb_prod_dns" { value = aws_lb.prod.dns_name }
output "alb_stg_dns"  { value = aws_lb.stg.dns_name }

# Target Groups
output "tg_prod_frontend_arn" { value = aws_lb_target_group.prod_frontend.arn }
output "tg_prod_backend_arn"  { value = aws_lb_target_group.prod_backend.arn }
output "tg_stg_frontend_arn"  { value = aws_lb_target_group.stg_frontend.arn }
output "tg_stg_backend_arn"   { value = aws_lb_target_group.stg_backend.arn }

# SGs creados por TF
output "sg_rds_public_id"   { value = aws_security_group.rds_public.id }

