# EC2
variable "region" {
  type = string
  default = "ap-south-1"
}

variable "vpc_id" {
  type = string
}

variable "aws_public_subnet" {
  type = string
  default = ""
}

variable "aws_route_table" {
  type = string
  default = ""
}


variable "aws_internet_gateway" {
  type = string
  default = ""
}

variable "aws_security_group" {
  type = string
  default = ""
}


variable "aws_instance" {
  type = string
  default = ""
}


variable "instance_type" {
  type = string
  default = ""
}


############# EKS #############

variable "cluster_name" { 
  type = string
}

variable "tags" { 
  type = string
}

variable "cluster_version" { 
  type = string
}

variable "cluster_endpoint_public_access" {
  type = bool
}

variable "enable_cluster_creator_admin_permissions" {
  type = bool
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
