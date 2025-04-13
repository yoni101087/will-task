variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "List of public subnet CIDRs"
  default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "private_subnet_cidrs" {
  description = "List of private subnet CIDRs"
  default     = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
}

variable "azs" {
  description = "Availability zones for subnets"
  default     = ["us-west-2a", "us-west-2b", "us-west-2c"]
}

variable "tags" {
  description = "Common resource tags"
  type        = map(string)
  default = {
    Terraform   = "true"
    Environment = "dev"
  }
}

variable "cluster_name" {
  description = "Name of the EKS cluster"
  default     = "dummy-data-cluster"
}

variable "cluster_version" {
  description = "EKS Kubernetes version"
  default     = "1.29"
}

variable "repository_name" {
  description = "ECR repository name"
  default     = "dummy-api-repo"
}

variable "db_name" {
  description = "Name of the PostgreSQL database"
  default     = "dummydb"
}

variable "db_username" {
  description = "Database admin username"
  default     = "super"
}

variable "db_password" {
  description = "Database admin password"
  default     = "ChangeMe123!"
}

variable "instance_class" {
  description = "RDS instance class"
  default     = "db.t3.micro"
}

variable "alb_name" {
  description = "Name of the Application Load Balancer"
  default     = "eks-alb"
}

variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-west-2"
}

variable "eks_cluster_exists" {
  description = "Does the EKS cluster exist in this environment?"
  type        = bool
  default     = false
}


