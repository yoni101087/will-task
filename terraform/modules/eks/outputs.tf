output "cluster_endpoint" {
  value = module.eks.cluster_endpoint
}

output "node_group_role_name" {
  value = module.eks.eks_managed_node_groups["one"].iam_role_name
}
output "ebs_csi_addon_arn" {
  value = aws_eks_addon.ebs-csi.arn
}