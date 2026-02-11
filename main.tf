# ------------------------
# VPC MODULE
# ------------------------
module "vpc" {
  source = "./modules/vpc"

  vpc_name             = "bhushan-vpc"
  vpc_cidr             = "10.0.0.0/16"
  public_subnet_cidr_1 = "10.0.1.0/24"
  public_subnet_cidr_2 = "10.0.2.0/24"
  az_1                 = "us-east-1a"
  az_2                 = "us-east-1b"
}

# ------------------------
# SECURITY GROUP MODULE
# ------------------------
module "security_grp" {
  source  = "./modules/security_grp"
  vpc_id  = module.vpc.vpc_id
  sg_name = "bhushan-sg"
}

# ------------------------
# EC2 MODULE
# ------------------------
module "ec2" {
  source = "./modules/ec2"

  ami               = "ami-0c02fb55956c7d316"
  instance_type     = "t2.micro"
  subnet_id         = module.vpc.public_subnet_ids[0]
  security_group_id = module.security_grp.sg_id
  key_name          = "bhushan-key"
  instance_name     = "bhushan-ec2"
}

# ------------------------
# ALB MODULE
# ------------------------
module "alb" {
  source = "./modules/alb"

  alb_name          = "bhushan-alb"
  subnet_ids        = module.vpc.public_subnet_ids # ✅ List
  security_group_id = module.security_grp.sg_id
  vpc_id            = module.vpc.vpc_id
}

# ------------------------
# Attach EC2 to Target Group
# ------------------------
resource "aws_lb_target_group_attachment" "ec2_attachment" {
  target_group_arn = module.alb.target_group_arn
  target_id        = module.ec2.instance_id
  port             = 80
}
