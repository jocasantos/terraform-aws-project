variable "subnet_ids" {
  description = "List of subnet IDs where the load balancer should be placed."
  type        = list(string)
}

variable "vpc_id" {
  description = "VPC ID where the target group will be created."
  type        = string
}

variable "security_group_ids" {
  description = "List of security group IDs for the ALB."
  type        = list(string)
}
