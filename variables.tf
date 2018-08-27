variable "postgres_user" {}
variable "postgres_password" {}

variable "aws_profile" {
    default = "default"
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