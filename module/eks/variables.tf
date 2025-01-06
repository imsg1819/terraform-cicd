

variable "cluster_name" {
  type = string
  default = ""
}

variable "cluster_endpoint_public_access" {
  type = bool
  default = false
}

variable "enable_cluster_creator_admin_permissions" {
  type = bool
  default = false
}

variable "vpc_id" {
  type = string
  default = ""
}

variable "subnet_ids" {
  type = list(string)
  default = []
}

variable "tags" {
  type = string
  default = ""
}

variable "eks_ami_type" {
  type = string
  default = "AL2_x86_64"  # Default for Amazon Linux 2 AMI
}

variable "eks_instance_type" {
  type    = string
  default = "t3.medium"
}

variable "eks_min_size" {
  type = number
  default = 1
}

variable "eks_max_size" {
  type = number
  default = 2
}

variable "eks_desired_size" {
  type = number
  default = 1
}

variable "cluster_version" {
  type = string
  default = ""
}
