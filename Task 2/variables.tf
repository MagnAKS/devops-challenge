variable "network_interface_id" {
  type = string
  default = "network_id_from_aws"
}

variable "ami" {
    type = string
    default = "ami-005e54dee72cc1d00"
}

variable "instance_type" {
    type = string
    default = "t2.micro"
}

variable "region" {
    type = string
    default = "ap-southeast-1"
}

variable "ecr_repository" {
    type = string
}
