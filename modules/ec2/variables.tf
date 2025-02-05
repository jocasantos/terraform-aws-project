variable "public_subnet_ids" {
  description = "List of public subnet IDs"
  type        = list(string)
}

variable "ami" {
  description = "AMI ID for the EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "target_group_arn" {
  description = "The ARN of the target group to register the instances with."
  type        = string
}
