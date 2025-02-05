resource "aws_security_group" "ec2_sg" {
  name        = "ec2-sg"
  description = "Security group for EC2 instances"
  vpc_id      = var.vpc_id
}

resource "aws_vpc_security_group_ingress_rule" "allow_http" {
  security_group_id = aws_security_group.ec2_sg.id
  ip_protocol          = "tcp"
  from_port         = 80
  to_port           = 80
  cidr_ipv4 =        "0.0.0.0/0"
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh" {
  security_group_id = aws_security_group.ec2_sg.id
  ip_protocol          = "tcp"
  from_port         = 22
  to_port           = 22
  cidr_ipv4 =        "0.0.0.0/0"
}

resource "aws_vpc_security_group_egress_rule" "allow_all_outbound" {
  security_group_id = aws_security_group.ec2_sg.id
  ip_protocol          = "-1"  # Allows all traffic
  from_port         = 0
  to_port           = 0
  cidr_ipv4 =  "0.0.0.0/0"
}

resource "aws_instance" "web" {
  count         = 2  # Two instances in different subnets
  ami           = var.ami  # Replace with an appropriate AMI ID for your region
  instance_type = var.instance_type       # Choose the instance size you need
  subnet_id     = element(var.public_subnet_ids, count.index)

  vpc_security_group_ids = [aws_security_group.ec2_sg.id]

  tags = {
    Name = "WebServer ${count.index + 1}"
  }
}

resource "aws_lb_target_group_attachment" "instance_attachment" {
  count              = 2  # Attach two instances
  target_group_arn   = var.target_group_arn
  target_id          = aws_instance.web[count.index].id  # Attach instance IDs
  port               = 80  # Traffic is forwarded to port 80 on the instances
}
