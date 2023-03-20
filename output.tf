output "subnet1-id" {
  value = aws_subnet.eight-public-subnet1.id
}

output "ec2-securitygroup-id" {
    value = aws_security_group.docker-golden-sg.id
}