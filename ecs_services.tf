# ======== PROD ========
resource "aws_ecs_service" "backend_prod" {
  name            = "backend-service"
  cluster         = aws_ecs_cluster.this.id
  task_definition = aws_ecs_task_definition.backend_prod.arn
  desired_count   = 1
  enable_ecs_managed_tags = true
  platform_version        = var.ecs_platform_version_prod

  capacity_provider_strategy {
    capacity_provider = "FARGATE"
    weight            = 1
    base              = 0
  }
  deployment_circuit_breaker { 
    enable = true 
    rollback = true 
  }

  network_configuration {
    subnets          = local.selected_public_subnet_ids
    security_groups  = [aws_security_group.ecs_services.id]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.prod_backend.arn
    container_name   = var.be_prod_container_name
    container_port   = 80
  }
}

resource "aws_ecs_service" "frontend_prod" {
  name            = "frontend-service"
  cluster         = aws_ecs_cluster.this.id
  task_definition = aws_ecs_task_definition.frontend_prod.arn
  desired_count   = 1
  enable_ecs_managed_tags = true
  platform_version        = var.ecs_platform_version_prod

  capacity_provider_strategy { 
    capacity_provider = "FARGATE" 
    weight = 1
    base = 0 
  }
  deployment_circuit_breaker { 
    enable = true 
    rollback = true 
  }

  network_configuration {
    subnets          = local.selected_public_subnet_ids
    security_groups  = [aws_security_group.ecs_services.id]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.prod_frontend.arn
    container_name   = var.fe_prod_container_name
    container_port   = 80
  }
}

# ======== STG ========
resource "aws_ecs_service" "backend_stg" {
  name            = "backend-stg-service"
  cluster         = aws_ecs_cluster.this.id
  task_definition = aws_ecs_task_definition.backend_stg.arn
  desired_count   = 1
  enable_ecs_managed_tags = true
  platform_version        = var.ecs_platform_version_stg

  capacity_provider_strategy { 
    capacity_provider = "FARGATE"
    weight = 1 
    base = 0 
  }
  deployment_circuit_breaker { 
    enable = true 
    rollback = true 
  }

  network_configuration {
    subnets          = local.selected_public_subnet_ids
    security_groups  = [aws_security_group.ecs_services.id]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.stg_backend.arn
    container_name   = var.be_stg_container_name
    container_port   = 80
  }
}

resource "aws_ecs_service" "frontend_stg" {
  name            = "frontend-stg-service"
  cluster         = aws_ecs_cluster.this.id
  task_definition = aws_ecs_task_definition.frontend_stg.arn
  desired_count   = 1
  enable_ecs_managed_tags = true
  platform_version        = var.ecs_platform_version_stg

  capacity_provider_strategy { 
    capacity_provider = "FARGATE"
    weight = 1
    base = 0 
  }
  deployment_circuit_breaker { 
    enable = true
    rollback = true 
  }

  network_configuration {
    subnets          = local.selected_public_subnet_ids
    security_groups  = [aws_security_group.ecs_services.id]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.stg_frontend.arn
    container_name   = var.fe_stg_container_name
    container_port   = 80
  }
}