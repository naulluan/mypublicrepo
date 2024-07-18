https://github.com/awslabs/eks-node-viewer/releases/download/v0.6.0/eks-node-viewer_Linux_x86_64

https://github.com/oras-project/oras/releases/download/v1.2.0/oras_1.2.0_linux_amd64.tar.gz
https://github.com/aquasecurity/trivy/releases/download/v0.52.2/trivy_0.52.2_Linux-64bit.tar.gz


module "karpenter" {
  source = "./modules/karpenter"

  create = var.enable_karpenter == true ? true : false
  # main
  irsa_oidc_provider_arn = try(aws_iam_openid_connect_provider.oidc_provider[0].arn, null)
  infra_node_role_arn    = element([for group in module.eks_managed_node_group : group.iam_role_arn], 0)
  policies               = var.policies

  # helm
  helm_version                       = var.helm_version
  cluster_name                       = try(aws_eks_cluster.this[0].name, "")
  cluster_endpoint                   = try(aws_eks_cluster.this[0].endpoint, null)
  cluster_certificate_authority_data = try(aws_eks_cluster.this[0].certificate_authority[0].data, null)
  aws_iam_instance_profile_name      = element([for group in module.eks_managed_node_group : group.aws_iam_instance_profile_name], 0)
  tolerations                        = var.tolerations
}

https://github.com/kubernetes-sigs/kui/releases/download/v13.1.4/Kui-linux-x64.zip

https://github.com/terraform-docs/terraform-docs/releases/download/v0.18.0/terraform-docs-v0.18.0-linux-amd64.tar.gz
