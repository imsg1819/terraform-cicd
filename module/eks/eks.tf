# module "eks_al2" {
#   source  = "terraform-aws-modules/eks/aws"
#   version = "~> 20.0"

#   cluster_name    = "${var.cluster_name}-al2"
#   cluster_version = var.cluster_version

#   # EKS Addons
#   cluster_addons = {
#     coredns                = {}
#     eks-pod-identity-agent = {}
#     kube-proxy             = {}
#     vpc-cni                = {}
#   }

#   vpc_id = var.vpc_id
#   subnet_ids = var.subnet_ids

#   eks_managed_node_groups = {
#     example_node_groups = {
#       # ami_type       = var.eks_ami_type
#       # instance_types = [
#         # var.eks_instance_type
#       # ]

#       min_size = var.eks_min_size
#       # max_size = var.eks_max_size
#       # desired_size = var.eks_desired_size
#     }
#   }

#   tags = var.tags
# }


module "eks_al2" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = "${var.cluster_name}-al2"
  cluster_version = var.cluster_version

  # EKS Addons
  cluster_addons = {
    coredns                = {}
    eks-pod-identity-agent = {}
    kube-proxy             = {}
    vpc-cni                = {}
  }

  vpc_id = var.vpc_id
  subnet_ids = var.subnet_ids

  eks_managed_node_groups = {
    example_node_groups = {
      ami_type        = var.eks_ami_type
      instance_types  = [var.eks_instance_type]
      min_size        = var.eks_min_size
      max_size        = var.eks_max_size
      desired_size    = var.eks_desired_size
    }
  }

  tags = var.tags
}
