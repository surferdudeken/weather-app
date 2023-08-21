# AWS provider for east 2 region 
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
# EKS module 
module "eks" {
  source          = "terraform-aws-modules/eks/aws"  
  cluster_name    = "weather-microservice" 
  version         = "19.16.0" 
  vpc_id          = "vpc-00a8c79fe20baab1f"                  
  cluster_version = "1.27"                         
  subnet_ids      = ["subnet-0a426585c2fdad736", "subnet-060391912e702e8e1"] 

# configure 1 node to keep cost down. 
  eks_managed_node_groups = {
    eks_nodes = {
      desired_capacity = 1
      max_capacity     = 2
      min_capacity     = 1
      instance_type    = "t2.micro" 
    }
  }
}
