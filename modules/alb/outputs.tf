output "load_balancer_arn" {
  value = aws_lb.app_lb.arn
}

output "target_group_arn" {
  value = aws_lb_target_group.app_target_group.arn
}
