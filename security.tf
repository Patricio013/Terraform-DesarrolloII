locals {
  name      = "${var.project}-${var.env}"
}

# Si no nos dan SG de ALB, lo creamos en la VPC seleccionada
resource "aws_security_group" "alb" {
  count       = var.alb_sg_id == "" ? 1 : 0
  name        = "${var.project}-${var.env}-alb-sg"
  description = "ALB ingress 80/egress all"
  vpc_id      = local.selected_vpc_id

  ingress {
    description = "HTTP from Internet"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Abstraemos el SG de ALB a usar
locals {
  alb_sg_id_effective = var.alb_sg_id != "" ? var.alb_sg_id : aws_security_group.alb[0].id
}

# SG para tareas ECS (mismo VPC que el ALB)
resource "aws_security_group" "ecs_services" {
  name   = "arreglaya-ecs-services-sg"
  vpc_id = local.selected_vpc_id

  ingress {
    description     = "ALB to ECS services on 80"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [local.alb_sg_id_effective]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# SG para RDS (mismo VPC seleccionado)
resource "aws_security_group" "rds_public" {
  name        = "arreglaya-rds-public-sg"
  description = "Permite 5432 desde Internet"
  vpc_id      = local.selected_vpc_id

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}