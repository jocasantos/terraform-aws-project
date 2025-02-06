# Terraform AWS Project
Guide on setting up infrastructure on AWS using Terraform 

### Pre-requisites
- AWS CLI
- Terraform (https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)

### Project overview

![infrastructure diagram](/vpc-diagram.png?raw=true)

- Create a new VPC with 2 public subnets (in 2 different AZs), an Internet Gateway (IGW) and Routetables for connect the public subnets and the Internet Gateway.
- Create 2 EC2 instances with Metadata (attach shell script) and a Security Group (don't forget to create the inbound and outbound rules).
- Create an Application Load Balancer (ALB), a Target Group for the instances, a Listener for the ALB and a Listener Rule. (Use the same Security Group for the EC2 Instances and the Load Balancer)
- Don't forget to attach the instances to the target group on the EC2 module.
- Edit the variables.tf (root level) with your data (Region, ami and instance type)

### In the end, connect to your Load Balancer DNS and refresh the connection to see the Load Balancer redirect the traffic (2 different EC2 instances IDs).

Congratulations! You have successfully deploy a load balancer and a complete infrastructure with Terraform :tada:
