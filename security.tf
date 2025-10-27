locals {
  name = "${var.project}-${var.env}"
}

# SG del ALB (entrada pública a 80)
resource "aws_security_group" "alb" {
  name   = "arreglaya-alb-sg"
  vpc_id = aws_vpc.this.id

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

# SG para las tareas ECS (backend/frontend)
# Opción recomendada: permitir solo desde el SG del ALB
resource "aws_security_group" "ecs_services" {
  name   = "arreglaya-ecs-services-sg"
  vpc_id = aws_vpc.this.id

  ingress {
    description     = "ALB to ECS services on 80"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.alb.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# (Si usas RDS públicas como en tus capturas, deja este SG)
resource "aws_security_group" "rds_public" {
  name        = "arreglaya-rds-public-sg"
  description = "Permite 5432 desde Internet (como hoy)"
  vpc_id      = aws_vpc.this.id

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