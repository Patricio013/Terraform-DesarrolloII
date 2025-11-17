# ALB PROD
resource "aws_lb" "prod" {
  name               = "ALB"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [local.alb_sg_id_effective]
  subnets            = local.selected_public_subnet_ids
}

resource "aws_lb_target_group" "prod_frontend" {
  name        = "tg-frontend-80"
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = local.selected_vpc_id
  health_check {
    path = "/"
    matcher = "200"
    healthy_threshold = 5
    unhealthy_threshold = 2
    interval = 30
    timeout  = 5
  }
}

resource "aws_lb_target_group" "prod_backend" {
  name        = "backend-target"
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = local.selected_vpc_id
  health_check {
    path = "/api/actuator/health"
    matcher = "200"
    healthy_threshold = 5
    unhealthy_threshold = 2
    interval = 30
    timeout  = 5
  }
}

resource "aws_lb_listener" "prod_http" {
  load_balancer_arn = aws_lb.prod.arn
  port              = 80
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.prod_frontend.arn
  }
}

resource "aws_lb_listener_rule" "prod_api" {
  listener_arn = aws_lb_listener.prod_http.arn
  priority     = 1
  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.prod_backend.arn
  }
  condition { 
    path_pattern { values = ["/api/*", "/actuator/*"] } 
  }
}

# ALB STG
resource "aws_lb" "stg" {
  name               = "alb-stg"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [local.alb_sg_id_effective]
  subnets            = local.selected_public_subnet_ids
}

resource "aws_lb_target_group" "stg_frontend" {
  name        = "tg-frontend-stg"
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = local.selected_vpc_id
  health_check {
    path = "/"
    matcher = "200"
    healthy_threshold = 5
    unhealthy_threshold = 2
    interval = 30
    timeout  = 5
  }
}

resource "aws_lb_target_group" "stg_backend" {
  name        = "tg-backend-stg"
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = local.selected_vpc_id
  health_check {
    path = "/"
    matcher = "200"
    healthy_threshold = 5
    unhealthy_threshold = 2
    interval = 30
    timeout  = 5
  }
}

resource "aws_lb_listener" "stg_http" {
  load_balancer_arn = aws_lb.stg.arn
  port              = 80
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.stg_frontend.arn
  }
}

resource "aws_lb_listener_rule" "stg_api" {
  listener_arn = aws_lb_listener.stg_http.arn
  priority     = 1
  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.stg_backend.arn
  }
  condition { 
    path_pattern { values = ["/api/*"] } 
  }
}