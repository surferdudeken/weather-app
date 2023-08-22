provider "aws" {
  region = "us-east-2"
}

terraform {
  backend "s3" {
    bucket = "s3tfstateohio"
    key    = "weather-microservice.tfstate"
    region = "us-east-2"
  }
}

resource "aws_security_group" "eks_security_group" {
  name        = "eks_security_group"
  description = "Security Group for EKS Cluster"
  vpc_id      = "vpc-00a8c79fe20baab1f"
}

resource "aws_security_group_rule" "allow_all_outbound" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.eks_security_group.id
}

module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  cluster_name    = "weather-microservice"
  version         = "19.16.0"
  vpc_id          = "vpc-00a8c79fe20baab1f"
  cluster_version = "1.27"
  subnet_ids      = ["subnet-0a426585c2fdad736", "subnet-060391912e702e8e1"]
  cluster_endpoint_public_access  = true
  cluster_endpoint_private_access = true
  iam_role_arn = "arn:aws:iam::575441150451:role/full_eks"

  eks_managed_node_groups = {
    eks_nodes = {
      desired_capacity = 1
      max_capacity     = 2
      min_capacity     = 1
      instance_type    = "t2.medium"
      iam_role_arn     = "arn:aws:iam::575441150451:role/full_eks"
      create_iam_role  = false
      additional_security_group_ids = [aws_security_group.eks_security_group.id]
    }
  }
  # Quick dirty workaround to open all ports for additional security groups
  cluster_security_group_additional_rules = {
    additional_ingress_rule = {
      type         = "ingress"
      cidr_blocks  = ["0.0.0.0/0"]
      from_port    = 0
      to_port      = 65535
      protocol     = "tcp"
    },
    additional_egress_rule = {
      type         = "egress"
      cidr_blocks  = ["0.0.0.0/0"]
      from_port    = 0
      to_port      = 65535
      protocol     = "tcp"
    }
  }
}