module "eks" {
  source = "terraform-aws-modules/eks/aws"

  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version

  vpc_id     = var.vpc_id
  subnet_ids = var.subnet_ids

  cluster_endpoint_public_access           = var.cluster_endpoint_public_access
  enable_cluster_creator_admin_permissions = var.enable_cluster_creator_admin_permissions

  eks_managed_node_group_defaults = var.eks_managed_node_group_defaults
  eks_managed_node_groups         = var.eks_managed_node_groups
}

locals {
  cluster_name = var.cluster_name
}

data "aws_iam_policy" "ebs_csi_policy" {
  arn = var.ebs_csi_policy_arn
}

module "iam-assumable-role-with-oidc" {
  source                        = "terraform-aws-modules/iam/aws//modules/iam-assumable-role-with-oidc"
  create_role                   = true
  role_name                     = "AmazonEKSTFEBSCSIRole-${module.eks.cluster_name}"
  provider_url                  = module.eks.oidc_provider
  role_policy_arns              = [data.aws_iam_policy.ebs_csi_policy.arn]
  oidc_fully_qualified_subjects = var.ebs_csi_oidc_subjects
}

resource "aws_eks_addon" "ebs-csi" {
  cluster_name             = module.eks.cluster_name
  addon_name               = var.ebs_csi_addon_name
  addon_version            = var.ebs_csi_addon_version
  service_account_role_arn = module.iam-assumable-role-with-oidc.iam_role_arn
  tags                     = var.ebs_csi_addon_tags
}

resource "kubernetes_storage_class_v1" "gp3" {
  count = var.eks_cluster_exists ? 1 : 0
  metadata {
    name = var.storage_class_name
    annotations = {
      "storageclass.kubernetes.io/is-default-class" = "true"
    }
  }

  storage_provisioner = var.storage_class_provisioner
  reclaim_policy      = var.storage_class_reclaim_policy
  volume_binding_mode = var.storage_class_volume_binding_mode

  parameters = var.storage_class_parameters

  depends_on = [
    module.eks,
    aws_eks_addon.ebs-csi
  ]
}

resource "null_resource" "kubectl" {
  provisioner "local-exec" {
    command = "aws eks --region ${var.region} update-kubeconfig --name ${local.cluster_name}"
  }

  depends_on = [module.eks]
}
