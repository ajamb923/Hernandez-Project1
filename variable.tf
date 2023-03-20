/*  List of ALL Variable   */
#---------------------------#

variable "vpc_cidr" {
  description = "Please enter CIDR for VPC"
}

variable "ami" {
  description = "Please type in your AMI"
}

variable "key_name" {
  description = "Please type in your key name"
}

variable "instance_type" {
  description = "Please type in the instance class"
}

variable "availability_zone" {
  description = "Please type in the availability zone"
  #default     = "us-east-1a"
}

variable "private_subnet_cidr" {
  description = "Please type in the private subnet cidr range"
}

variable "private_ips" {
  description = "Private IPs for the instances"
}

variable "iamRole-ssm" {
  description = "Role for SSM"
}

variable "public_subnet_cidr" {
    description = "Please type in the public subnet cidr range"
}


variable "create_ALB" {
  description = "Do you want to create an ALB"
}

variable "create_AutoScaling" {
  description = "Do you want to create an AutoScaling"
}




# variable "sg_ports" {
#   description = "Ports for security group ingress rules"
# }