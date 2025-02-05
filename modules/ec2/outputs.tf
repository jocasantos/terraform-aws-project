output "ec2_instance_ids" {
  value = aws_instance.web[*].id
}

output "ec2_public_ips" {
  value = aws_instance.web[*].public_ip
}

output "ec2_sg_id" {
  value = aws_security_group.ec2_sg.id
}