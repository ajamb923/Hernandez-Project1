# /*  Docker Instance   */
# #----------------------------------------------#

# resource "aws_instance" "docker-instance" {
#   ami               = var.ami
#   instance_type     = var.instance_type
#   availability_zone = var.availability_zone[0]
#   user_data         = file("userdata-docker.sh")
#   iam_instance_profile = var.iamRole

#   network_interface {
#     device_index         = 0
#     network_interface_id = aws_network_interface.docker-NIC1.id
#   }

#   key_name = var.key_name
#   tags = {
#     Name = "Docker-BLACK"
#   }

#   depends_on = [aws_eip.docker-EIP1]
# }
