# EC2 
region = "ap-south-1"
vpc_id = "vpc-0d3e650a50a13bee4"
aws_public_subnet = "subnet-00b203acae5f9a766"
aws_route_table = "rtb-0887afc908023311b"
aws_internet_gateway = "igw-0e1944220ebe200b8"
aws_security_group = "vpc-0982bb300db57e65d"
aws_instance = "ami-053b12d3152c0cc71"
instance_type = "t2.medium"

# EKS
cluster_name = "eks"
cluster_version = "1.31"
cluster_endpoint_public_access = false
enable_cluster_creator_admin_permissions = true

eks_ami_type = ""
eks_instance_type = ""
eks_min_size = 1
eks_max_size = 2
eks_desired_size = 1
