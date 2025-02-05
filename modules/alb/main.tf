# Create Load Balancer (ALB)
resource "aws_lb" "app_lb" {
  name               = "app-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = var.security_group_ids
  subnets            = var.subnet_ids

  enable_deletion_protection    = false
  enable_cross_zone_load_balancing = true

  tags = {
    Name = "app-lb"
  }
}

# Create a Target Group for the instances
resource "aws_lb_target_group" "app_target_group" {
  name     = "app-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    interval            = 30
    path                = "/"
    port                = 80
    protocol            = "HTTP"
    timeout             = 5
    healthy_threshold   = 3
    unhealthy_threshold = 3
  }

  tags = {
    Name = "app-target-group"
  }
}

# Create a listener for the load balancer to listen on HTTP (port 80)
resource "aws_lb_listener" "http_listener" {
  load_balancer_arn = aws_lb.app_lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "fixed-response"
    fixed_response {
      status_code = 200
      content_type = "text/plain"
      message_body = "Healthy"
    }
  }
}

# Create a listener rule to forward traffic to the target group
resource "aws_lb_listener_rule" "default_forward" {
  listener_arn = aws_lb_listener.http_listener.arn
  priority     = 100

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app_target_group.arn
  }

  condition {
    path_pattern {
        values = [ "/" ]
    }
  }
}
