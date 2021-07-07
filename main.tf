provider "aws" {
  region = var.region
}


/* Create VPC and Subnets from terraform aws module */
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = var.vpc_name
  cidr = var.cidr

  azs             = var.azs_list
  private_subnets = var.private_subnets_list
  public_subnets  = var.public_subnets_list

  enable_nat_gateway = var.enable_nat_gateway
  enable_vpn_gateway = var.enable_vpn_gateway

  tags = {
    Terraform   = "true"
    Environment = var.env
  }

}

/* Create the ELB Security Group */
resource "aws_security_group" "elb_sg" {
  name = "${var.cluster_name}-elb"
  vpc_id = module.vpc.vpc_id
  # Outbound rules
  egress {
    from_port  = 0
    to_port    = 0
    protocol   = "-1"
    cidr_blocks = var.everywhere_cidr
  }

  # Inbound rules
  ingress {
    from_port  = var.elb_port
    to_port    = var.elb_port
    protocol   = "tcp"
    cidr_blocks = var.everywhere_cidr
  }
}

# Create an EC2 SG
resource "aws_security_group" "ec2_sg" {
  name = "${var.cluster_name}-ec2-sg"
  vpc_id = module.vpc.vpc_id
    # Inbound rules
  ingress {
    from_port  = var.elb_port
    to_port    = var.elb_port
    protocol   = "tcp"
     security_groups    = [aws_security_group.elb_sg.id]
  }
}



#Create the ELB
resource "aws_elb" "elb" {
  name               = "${var.cluster_name}-load-balancer"
  security_groups    = [aws_security_group.elb_sg.id]
  subnets            =flatten([module.vpc.public_subnets])
//  availability_zones = var.azs_list

  // Http listener
  listener {
    lb_port           = var.elb_port
    lb_protocol       = "http"
    instance_port     = var.server_port
    instance_protocol = "http"
  }

  // https listener
  listener {
    lb_port            = 443
    lb_protocol        = "https"
    instance_port      = var.server_port
    instance_protocol  = "http"
    ssl_certificate_id = "arn:aws:iam::123456789012:server-certificate/certName"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    interval            = 30
    target              = "HTTP:${var.server_port}/"
  }

}

