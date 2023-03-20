/*  Create Docker Instance   */
#----------------------------------------------#

resource "aws_instance" "docker-instance" {
  ami               = "ami-005f9685cb30f234b"
  instance_type     = "t2.micro"
  user_data         = file("userdata-docker.sh")
  associate_public_ip_address = true
  key_name = "NOVA_KP"
  subnet_id = module.VPC.subnet1-id
  vpc_security_group_ids = [module.VPC.ec2-securitygroup-id]

  tags = {
    Name = "Docker-Instance"
  }
}

output "docker-instance-id" {
    value = aws_instance.docker-instance.id
}



/*  Create Golden Image from Docker Instance  */
#----------------------------------------------#
resource "aws_ami_from_instance" "golden-image" {
  name               = "Golden Image"
  source_instance_id = aws_instance.docker-instance.id 
}



/*  Create Instance from Golden Image  */
#----------------------------------------------#

resource "aws_instance" "golden-instance" {
  ami               = aws_ami_from_instance.golden-image.id
  instance_type     = "t2.micro"
  user_data         = file("userdata-golden.sh")
  associate_public_ip_address = true
  key_name = "NOVA_KP"
  subnet_id = module.VPC.subnet1-id
  vpc_security_group_ids = [module.VPC.ec2-securitygroup-id]

  tags = {
    Name = "Golden-Instance"
  }
}

output "Golend-instance-id" {
    value = aws_instance.golden-instance.id
}
