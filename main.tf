
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
  aws_route_table = var.aws_route_table
  aws_internet_gateway = var.aws_internet_gateway
  aws_security_group = var.aws_security_group
  aws_instance = var.aws_instance
  instance_type = var.instance_type
}


module "eks_al2" {
  source = "./module/eks"
  cluster_version = var.cluster_version
  cluster_name = var.cluster_name
  cluster_endpoint_public_access = var.cluster_endpoint_public_access
  enable_cluster_creator_admin_permissions = var.enable_cluster_creator_admin_permissions
  ami_type       = var.eks_ami_type
  eks_instance_type = var.eks_instance_type
  min_size = var.eks_min_size
  max_size = var.eks_max_size
  desired_size = var.eks_desired_size
  vpc_id     = aws_vpc.default.id
  subnet_ids = module.ec2.aws_subnet_id
  tags = var.tags
}


