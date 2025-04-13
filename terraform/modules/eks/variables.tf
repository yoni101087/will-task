variable "cluster_name" {
  description = "Name of the Cluster"
  type = string
  default = "budgetbook"
}


variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-west-2"
}


variable "cluster_version" {
  type    = string
  default = "1.29"
}

variable "vpc_id" {
  type = string
}

variable "subnet_ids" {
  type = list(string)
}

variable "cluster_endpoint_public_access" {
  type    = bool
  default = true
}

variable "enable_cluster_creator_admin_permissions" {
  type    = bool
  default = true
}

variable "eks_managed_node_group_defaults" {
  type = any
  default = {
    ami_type = "AL2_x86_64"
  }
}

variable "eks_managed_node_groups" {
  type = any
  default = {
    one = {
      name           = "nodegroup-1"
      instance_types = ["t3.medium"]
      min_size       = 3
      max_size       = 3
      desired_size   = 3
    }
  }
}

variable "ebs_csi_policy_arn" {
  type    = string
  default = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
}

variable "ebs_csi_oidc_subjects" {
  type = list(string)
  default = ["system:serviceaccount:kube-system:ebs-csi-controller-sa"]
}

variable "ebs_csi_addon_name" {
  type    = string
  default = "aws-ebs-csi-driver"
}

variable "ebs_csi_addon_version" {
  type    = string
  default = "v1.29.1-eksbuild.1"
}

variable "ebs_csi_addon_tags" {
  type = map(string)
  default = {
    "eks_addon" = "ebs-csi"
    "terraform" = "true"
  }
}

variable "storage_class_name" {
  type    = string
  default = "gp3"
}

variable "storage_class_provisioner" {
  type    = string
  default = "ebs.csi.aws.com"
}

variable "storage_class_reclaim_policy" {
  type    = string
  default = "Delete"
}

variable "storage_class_volume_binding_mode" {
  type    = string
  default = "WaitForFirstConsumer"
}

variable "storage_class_parameters" {
  type = map(string)
  default = {
    type   = "gp3"
    fsType = "ext4"
  }
}


variable "eks_cluster_exists" {
  description = "Does EKS cluster exist in this environment"
  type        = bool
}
