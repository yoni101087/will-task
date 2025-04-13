terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.83"
      #version = "~> 4.66" # ✅ This satisfies everything from 4.46+ up to <5.0
    }

    random = {
      source  = "hashicorp/random"
      version = "~> 3.4.3"
    }

    tls = {
      source  = "hashicorp/tls"
      version = "~> 4.0.4"
    }

    cloudinit = {
      source  = "hashicorp/cloudinit"
      version = "~> 2.2.0"
    }

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.20.0"
    }
  }

  required_version = "~> 1.3"
}

#provider "kubernetes" {
#  host                   = data.aws_eks_cluster.cluster.endpoint
#  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority[0].data)
#  token                  = data.aws_eks_cluster_auth.cluster.token
#}

provider "kubernetes" {
  host                   = var.eks_cluster_exists ? data.aws_eks_cluster.cluster[0].endpoint : "https://dummy-endpoint"
  cluster_ca_certificate = var.eks_cluster_exists ? base64decode(data.aws_eks_cluster.cluster[0].certificate_authority[0].data) : ""
  token                  = var.eks_cluster_exists ? data.aws_eks_cluster_auth.cluster[0].token : ""
}




