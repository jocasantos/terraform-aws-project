module "vpc" {
  source = "./modules/vpc"
  vpc_cidr        = var.vpc_cidr
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets
}

module "ec2" {
  source            = "./modules/ec2"
  public_subnet_ids = module.vpc.public_subnet_ids
  ami           = var.ami  
  instance_type = var.instance_type  
  vpc_id            = module.vpc.vpc_id
  target_group_arn  = module.loadbalancer.target_group_arn
  userdata = var.userdata
}

module "loadbalancer" {
  source             = "./modules/alb"
  subnet_ids         = module.vpc.public_subnet_ids  # Pass the public subnet IDs to ALB
  vpc_id             = module.vpc.vpc_id  # Pass VPC ID to ALB
  security_group_ids = [module.ec2.ec2_sg_id]  # Pass the security group IDs to ALB
}