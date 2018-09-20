variable "postgres_user" {}
variable "postgres_password" {}

variable "aws_profile" {
    default = "default"
}
variable "multi_az" {
  default = true
}
variable "nat_mode" {
  description = "Could be 'gateway' or 'instance', read more: https://docs.aws.amazon.com/AmazonVPC/latest/UserGuide/vpc-nat-comparison.html"
  default = "gateway"
}

locals {
  nat_instance          = "${ var.nat_mode == "gateway" ? false : true }"
  nat_instance_multi_az = "${ local.nat_instance == false ? false : var.multi_az }"

  nat_gw                = "${ var.nat_mode == "gateway" ? true : false }"
  nat_gw_multi_az       = "${ local.nat_gw == false ? false : var.multi_az }"
}

variable "nat_instance_type" {
  default = "t2.small"
}

variable "namespace" {
    description = "AWS resource namespacing"
    default = "opensc"
}

variable "aws_region" {
    description = "EC2 Region for the VPC"
    default = "ap-southeast-2"
}

variable "vpc_cidr" {
    description = "CIDR for the whole VPC"
    default = "10.0.0.0/16"
}

variable "aws_availability_zones" {
    default = "ap-southeast-2a,ap-southeast-2b"
}