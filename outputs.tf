output "vpc_id"            { value = aws_vpc.this.id }
output "public_subnet_ids" { value = [aws_subnet.public_a.id, aws_subnet.public_b.id, aws_subnet.public_c.id] }
output "igw_id"            { value = aws_internet_gateway.igw.id }

output "rds_prod_endpoint" { value = aws_db_instance.prod.address }
output "rds_stg_endpoint"  { value = aws_db_instance.stg.address }

output "alb_prod_dns" { value = aws_lb.prod.dns_name }
output "alb_stg_dns"  { value = aws_lb.stg.dns_name }

output "tg_prod_frontend_arn" { value = aws_lb_target_group.prod_frontend.arn }
output "tg_prod_backend_arn"  { value = aws_lb_target_group.prod_backend.arn }
output "tg_stg_frontend_arn"  { value = aws_lb_target_group.stg_frontend.arn }
output "tg_stg_backend_arn"   { value = aws_lb_target_group.stg_backend.arn }

output "sg_alb_id"         { value = aws_security_group.alb.id }
output "sg_ecs_services_id"{ value = aws_security_group.ecs_services.id }

