data "aws_availability_zones" "available" {}

#data "aws_eks_cluster_auth" "cluster" {
#  name = var.cluster_name
#}

data "aws_eks_cluster_auth" "cluster" {
  count = var.eks_cluster_exists ? 1 : 0
  name  = "dummy-data-cluster"
}



#data "aws_eks_cluster" "cluster" {
#  name = var.cluster_name
#}

data "aws_eks_cluster" "cluster" {
  count = var.eks_cluster_exists ? 1 : 0
  name  = "dummy-data-cluster"
}