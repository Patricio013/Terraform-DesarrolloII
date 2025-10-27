############################
# ALB PRODUCCIÓN
############################
resource "aws_lb" "prod" {
  name               = "ALB"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb.id]
  subnets            = [aws_subnet.public_a.id, aws_subnet.public_b.id, aws_subnet.public_c.id]
}

resource "aws_lb_target_group" "prod_frontend" {
  name        = "tg-frontend-80"
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = aws_vpc.this.id
}

resource "aws_lb_target_group" "prod_backend" {
  name        = "backend-target"
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = aws_vpc.this.id
  health_check {
    path    = "/actuator/health"
    matcher = "200-399"
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
  priority     = 10
  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.prod_backend.arn
  }
  condition {
    path_pattern { values = ["/api/*", "/actuator/*"] }
  }
}

############################
# ALB STAGING
############################
resource "aws_lb" "stg" {
  name               = "alb-stg"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb.id]
  subnets            = [aws_subnet.public_a.id, aws_subnet.public_b.id, aws_subnet.public_c.id]
}

resource "aws_lb_target_group" "stg_frontend" {
  name        = "tg-frontend-stg"
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = aws_vpc.this.id
}

resource "aws_lb_target_group" "stg_backend" {
  name        = "tg-backend-stg"
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = aws_vpc.this.id
  health_check {
    path    = "/actuator/health"
    matcher = "200-399"
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
  priority     = 10
  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.stg_backend.arn
  }
  condition {
    path_pattern { values = ["/api/*"] }
  }
}