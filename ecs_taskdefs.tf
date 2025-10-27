# URLs de imagen por env
locals {
  be_prod_image = "${aws_ecr_repository.backend_prod.repository_url}:${var.image_tag_prod}"
  fe_prod_image = "${aws_ecr_repository.frontend_prod.repository_url}:${var.image_tag_prod}"
  be_stg_image  = "${aws_ecr_repository.backend_stg.repository_url}:${var.image_tag_stg}"
  fe_stg_image  = "${aws_ecr_repository.frontend_stg.repository_url}:${var.image_tag_stg}"
}

# ======== PROD ========

resource "aws_ecs_task_definition" "backend_prod" {
  family                   = "backend"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = tostring(var.be_prod_cpu)     # p.ej. 256
  memory                   = tostring(var.be_prod_memory)  # p.ej. 512
  execution_role_arn       = aws_iam_role.task_execution.arn
  runtime_platform { 
    cpu_architecture = "X86_64"
    operating_system_family = "LINUX" 
}

  container_definitions = jsonencode([{
    name         = var.be_prod_container_name     # "backend"
    image        = local.be_prod_image
    essential    = true
    portMappings = [{ containerPort = 80, protocol = "tcp" }]
    environment = [
      { name = "SPRING_PROFILES_ACTIVE",    value = "prod" },
      { name = "SPRING_DATASOURCE_URL",     value = "jdbc:postgresql://${aws_db_instance.prod.address}:5432/${var.db_prod_name}" },
      { name = "SPRING_DATASOURCE_USERNAME",value = var.db_username },
      { name = "SPRING_DATASOURCE_PASSWORD",value = var.db_prod_password }
    ]
    logConfiguration = {
      logDriver = "awslogs",
      options = {
        awslogs-group         = aws_cloudwatch_log_group.backend_prod.name,
        awslogs-region        = var.aws_region,
        awslogs-stream-prefix = "ecs"
      }
    }
  }])
}

resource "aws_ecs_task_definition" "frontend_prod" {
  family                   = "frontend"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = tostring(var.fe_prod_cpu)     # ajustable
  memory                   = tostring(var.fe_prod_memory)  # ajustable
  execution_role_arn       = aws_iam_role.task_execution.arn
  runtime_platform { 
    cpu_architecture = "X86_64"
    operating_system_family = "LINUX" 
}

  container_definitions = jsonencode([{
    name         = var.fe_prod_container_name     # "frontend"
    image        = local.fe_prod_image
    essential    = true
    portMappings = [{ containerPort = 80, protocol = "tcp" }]
    environment  = []
    logConfiguration = {
      logDriver = "awslogs",
      options = {
        awslogs-group         = aws_cloudwatch_log_group.frontend_prod.name,
        awslogs-region        = var.aws_region,
        awslogs-stream-prefix = "ecs"
      }
    }
  }])
}

# ======== STG ========

resource "aws_ecs_task_definition" "backend_stg" {
  family                   = "backend-stg"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = tostring(var.be_stg_cpu)     # 256 (según tu STG)
  memory                   = tostring(var.be_stg_memory)  # 512 (según tu STG)
  execution_role_arn       = aws_iam_role.task_execution.arn
  runtime_platform { 
    cpu_architecture = "X86_64" 
    operating_system_family = "LINUX" 
}

  container_definitions = jsonencode([{
    name         = var.be_stg_container_name      # "backend-stg"
    image        = local.be_stg_image
    essential    = true
    portMappings = [{ containerPort = 80, protocol = "tcp" }]
    environment = [
      { name = "SPRING_PROFILES_ACTIVE",    value = "stg" },
      { name = "SPRING_DATASOURCE_URL",     value = "jdbc:postgresql://${aws_db_instance.stg.address}:5432/${var.db_stg_name}" },
      { name = "SPRING_DATASOURCE_USERNAME",value = var.db_username },
      { name = "SPRING_DATASOURCE_PASSWORD",value = var.db_stg_password }
    ]
    logConfiguration = {
      logDriver = "awslogs",
      options = {
        awslogs-group         = aws_cloudwatch_log_group.backend_stg.name,
        awslogs-region        = var.aws_region,
        awslogs-stream-prefix = "ecs"
      }
    }
  }])
}

resource "aws_ecs_task_definition" "frontend_stg" {
  family                   = "frontend-stg"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = tostring(var.fe_stg_cpu)     # 1024 (según tu STG)
  memory                   = tostring(var.fe_stg_memory)  # 3072 (según tu STG)
  execution_role_arn       = aws_iam_role.task_execution.arn
  runtime_platform { 
    cpu_architecture = "X86_64" 
    operating_system_family = "LINUX" 
}

  container_definitions = jsonencode([{
    name         = var.fe_stg_container_name       # "frontend-stg"
    image        = local.fe_stg_image
    essential    = true
    portMappings = [{ containerPort = 80, protocol = "tcp" }]
    environment  = []
    logConfiguration = {
      logDriver = "awslogs",
      options = {
        awslogs-group         = aws_cloudwatch_log_group.frontend_stg.name,
        awslogs-region        = var.aws_region,
        awslogs-stream-prefix = "ecs"
      }
    }
  }])
}