provider "aws" {
  region = "us-west-2"
}

resource "aws_iam_openid_connect_provider" "eks" {
  url = "https://oidc.eks.us-west-2.amazonaws.com/id/5F6A2F681EDF2D52506A33524344A29"

  client_id_list = ["sts.amazonaws.com"]

  thumbprint_list = ["9e99a48a9960b14926bb7f3b02e22da0ecd2c3e4"] # Default AWS root CA thumbprint
}


module "vpc" {
  source  = "./modules/vpc"

  name                = "vpc"
  cidr                = "10.0.0.0/16"
  availability_zones  = slice(data.aws_availability_zones.available.names, 0, 3)

  private_subnets     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets      = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]

  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true

  public_subnet_tags = {
    "kubernetes.io/cluster/eks-cluster" = "shared"
    "kubernetes.io/role/elb"            = 1
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/eks-cluster" = "shared"
    "kubernetes.io/role/internal-elb"   = 1
  }
}




module "s3" {
  source = "./modules/s3"

  bucket_name       = "my-eks-ingestion-bucket"
  versioning_enabled = true
  force_destroy     = true
  node_group_role_name = module.eks.node_group_role_name

}

module "eks" {
  source = "./modules/eks"
  eks_cluster_exists = var.eks_cluster_exists
  cluster_name = var.cluster_name
  vpc_id       = module.vpc.vpc_id
  subnet_ids   = module.vpc.private_subnets
}


module "ecr" {
  source          = "./modules/ecr"
  repository_name = var.repository_name
  tags            = var.tags
}



module "security_groups" {
  source = "./modules/security_groups"
  vpc_id = module.vpc.vpc_id
}


module "rds" {
  source = "./modules/rds"

  subnet_ids  = module.vpc.private_subnets
  rds_sg_id   = module.security_groups.rds_sg_id
  db_username = var.db_username
  db_password = var.db_password
}



module "alb" {
  source     = "./modules/alb"
  name       = var.alb_name
  vpc_id     = module.vpc.vpc_id
  subnets    = module.vpc.public_subnets
  alb_sg_id  = module.security_groups.alb_sg_id
}



