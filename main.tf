
provider "aws" {
  region = var.region
}

data "aws_vpc" "default" {
  id = var.vpc_id
}

data "aws_subnet" "existing" {
  id = var.aws_public_subnet  # Existing subnet ID
}

module "ec2" {
  source = "./module/ec2"
  region = var.region
  aws_public_subnet = var.aws_public_subnet
  aws_security_group = var.aws_security_group
  instance_type = var.instance_type
}

module "eks_al2" {
  source = "./module/eks"
  cluster_version = var.cluster_version
  cluster_endpoint_public_access = var.cluster_endpoint_public_access
  enable_cluster_creator_admin_permissions = var.enable_cluster_creator_admin_permissions
  eks_instance_type = var.eks_instance_type
  vpc_id = var.vpc_id
  subnet_ids = var.subnet_ids
}

resource "aws_eks_node_group" "demo" {
  cluster_name    = module.eks_al2.cluster_name
  node_group_name = "demo"
  node_role_arn   = aws_iam_role.demo.arn
  subnet_ids      = var.subnet_ids

  scaling_config {
    desired_size = var.eks_desired_size
    max_size     = var.eks_max_size
    min_size     = var.eks_min_size
  }

  update_config {
    max_unavailable = 1
  }

  depends_on = [
    aws_iam_role_policy_attachment.demo-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.demo-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.demo-AmazonEC2ContainerRegistryReadOnly,
  ]
}
