// Module

module "VPC" {
    source = "../../Hernandez-Project1"
    ami                 = "ami-005f9685cb30f234b"
    key_name            = "NOVA_KP"
    instance_type       = "t2.micro"
    availability_zone   = ["us-east-1a", "us-east-1b"]
    private_subnet_cidr = ["8.0.10.0/24", "8.0.11.0/24"]
    private_ips         = ["8.0.10.23", "8.0.11.23", "8.0.20.23", "8.0.21.23", "8.0.30.23", "8.0.31.23"]
    vpc_cidr            = "8.0.0.0/16"
    iamRole-ssm = "ec2Role4-SSM"
    public_subnet_cidr = ["8.0.1.0/24","8.0.2.0/24"]
    create_ALB = false
    create_AutoScaling = false
}