variable "cluster_name" {
  type = string
}

variable "cluster_endpoint_public_access" {
  type = bool
}

variable "enable_cluster_creator_admin_permissions" {
  type = bool
}

# variable "cluster_compute_config" {
#   type = map()
# }

variable "vpc_id" {
  type = string
}

variable "subnet_ids" {
  type = string
}

variable "tags" {
  type = string
}

variable "eks_ami_type" {
  type = string
}
variable "eks_instance_type" {
  type = string
}
variable "eks_min_size" {
  type = number
}
variable "eks_max_size" {
  type = number
}
variable "eks_desired_size" {
  type = number
}

variable "cluster_version" {
  type = number
}