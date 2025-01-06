
# data "aws_vpc" "default" {
#   id = var.vpc_id
# }

# data "aws_subnet" "existing" {
#   id = var.aws_public_subnet  # Existing subnet ID
# }

# module "ec2" {
#   source = "./module/ec2"
#   region = var.region
#   aws_public_subnet = var.aws_public_subnet
#   aws_route_table = var.aws_route_table
#   aws_internet_gateway = var.aws_internet_gateway
#   aws_security_group = var.aws_security_group
#   aws_instance = var.aws_instance
#   instance_type = var.instance_type
# }


# module "eks_al2" {
#   source = "./module/eks"
#   cluster_version = var.cluster_version
#   #cluster_name.cluster_name
#   cluster_endpoint_public_access = var.cluster_endpoint_public_access
#   enable_cluster_creator_admin_permissions = var.enable_cluster_creator_admin_permissions
#   #ami_type       = var.eks_ami_type
#   eks_instance_type = var.eks_instance_type
#   #min_size = var.eks_min_size
#   #max_size = var.eks_max_size
#   #desired_size = var.eks_desired_size
#   vpc_id     = aws_vpc.default.id
#   subnet_ids = module.ec2.aws_subnet_id
#   #tags =#  var.tags
#  }

# resource "aws_eks_node_group" "demo" {
#   cluster_name    = aws_eks_cluster.demo.name
#   node_group_name = "demo"
#   node_role_arn   = aws_iam_role.demo.arn
#   subnet_ids      = aws_subnet.demo[*].id

#   scaling_config {
#     desired_size = 1
#     max_size     = 2
#     min_size     = 1
#   }

#   update_config {
#     max_unavailable = 1
#   }

#   # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
#   # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
#   depends_on = [
#     aws_iam_role_policy_attachment.demo-AmazonEKSWorkerNodePolicy,
#     aws_iam_role_policy_attachment.demo-AmazonEKS_CNI_Policy,
#     aws_iam_role_policy_attachment.demo-AmazonEC2ContainerRegistryReadOnly,
#   ]
# }

# --------------------------------------------------------------------------------------------------
# --------------------------------------------------------------------------------------------------

# # data "aws_vpc" "default" {
# #   id = var.vpc_id
# # }

# # data "aws_subnet" "existing" {
# #   id = var.aws_public_subnet  # Existing subnet ID
# # }

# # module "ec2" {
# #   source            = "./module/ec2"
# #   region            = var.region
# #   aws_public_subnet = var.aws_public_subnet
# #   aws_route_table   = var.aws_route_table
# #   aws_internet_gateway = var.aws_internet_gateway
# #   aws_security_group = var.aws_security_group
# #   aws_instance      = var.aws_instance
# #   instance_type     = var.instance_type
# # }

# # module "eks_al2" {
# #   source = "./module/eks"

# #   cluster_version                   = var.cluster_version
# #   cluster_name                      = var.cluster_name
# #   cluster_endpoint_public_access    = var.cluster_endpoint_public_access
# #   enable_cluster_creator_admin_permissions = var.enable_cluster_creator_admin_permissions
# #   # eks_instance_type                 = var.eks_instance_type
# #   #min_size                          = var.eks_min_size
# #   # ami_type                          = var.eks_ami_type
# #   # max_size                          = var.eks_max_size
# #   # desired_size                      = var.eks_desired_size
# #   vpc_id                            = aws_vpc.default.id
# #   subnet_ids                        = module.ec2.aws_subnet_id
# #   tags                              = var.tags
# # }


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