# Create Target Group
resource "aws_lb_target_group" "app_tg" {
  name     = var.default_name
  port     = var.container_port
  protocol = "HTTP"
  vpc_id   = var.aws_vpc_id

  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}

# Create Load Balancer
resource "aws_lb" "app_lb" {
  name               = var.default_name
  internal           = false
  load_balancer_type = "application"
  security_groups    = var.security_groups
  subnets            = var.aws_subnet_ids

  enable_deletion_protection = false

  depends_on = [aws_lb_target_group.app_tg]
}

# Create Listener 80
resource "aws_lb_listener" "app_listener" {
  load_balancer_arn = aws_lb.app_lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app_tg.arn
  }

  depends_on = [aws_lb.app_lb]
}

# # Create Listener 443
# resource "aws_lb_listener" "app_listener_443" {
#   load_balancer_arn = aws_lb.app_lb.arn
#   port              = 443
#   protocol          = "HTTPS"
#   ssl_policy        = "ELBSecurityPolicy-2016-08"
#   certificate_arn   = aws_acm_certificate.app_cert.arn

#   default_action {
#     type             = "forward"
#     target_group_arn = aws_lb_target_group.app_tg.arn
#   }

#   depends_on = [aws_lb.app_lb, aws_acm_certificate.app_cert]
# }

# Create ECS Task Definition
resource "aws_ecs_service" "app_service" {
  name            = var.default_name
  cluster         = var.aws_ecs_service_cluster_name
  task_definition = aws_ecs_task_definition.app.arn
  desired_count   = var.desired_count
  launch_type     = var.launch_type

  load_balancer {
    target_group_arn = aws_lb_target_group.app_tg.arn
    container_name   = var.default_name
    container_port   = var.container_port
  }

  depends_on = [
    aws_lb_listener.app_listener,
    aws_lb_target_group.app_tg
  ]
}

variable "aws_route53_zone_id" {
  description = "AWS Route 53 Zone ID"
  default = ""
}

# # Route 53
# resource "aws_route53_record" "app_route53" {
#   zone_id = var.aws_route53_zone_id
#   name    = var.default_name
#   type    = "A"
#   ttl     = "300"
#   records = [aws_lb.app_lb.dns_name]
# }

# # certificate for the domain
# resource "aws_acm_certificate" "app_cert" {
#   domain_name       = var.default_name
#   validation_method = "DNS"

#   tags = {
#     Name = var.default_name
#   }
# }

# # Route 53
# resource "aws_route53_record" "app_route53_cert" {
#   zone_id = var.aws_route53_zone_id
#   name    = var.default_name
#   type    = "CNAME"
#   ttl     = "300"
#   records = [aws_acm_certificate_validation.app_cert.domain_validation_options.0.resource_record_name]
# }

# resource "aws_acm_certificate_validation" "app_cert" {
#   certificate_arn         = aws_acm_certificate.app_cert.arn
#   validation_record_fqdns = [aws_route53_record.app_route53_cert.fqdn]
# }