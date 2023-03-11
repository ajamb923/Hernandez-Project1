# Create instance

# create launch template 
# Create autoscaling group

# configure ssm - role
# create vpc endpoint for connectivity between ssm and instance
# make sure to select ami that has ssm agent baked in it.
# create  ssm endpoint
    # com.amazonaws.us-east-1.ssm
    # com.amazonaws.us-east-1.ssmmessages
    # restart instances


/*  Create Launch Template  */
#----------------------------#
resource "aws_launch_template" "eight-Launch-Temp" {
  name = "eight-tp"  
  image_id      = var.ami
  instance_type = var.instance_type
  #key_name = var.key_name

  #security_group_names = [aws_security_group.eight-instances-sg.name]
  
  iam_instance_profile {
     name = var.iamRole-ssm
  }

  vpc_security_group_ids = [aws_security_group.eight-instances-sg.id]

  user_data = filebase64("userdata.sh")

  #depends_on = [aws_security_group.eight-instances-sg]

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "Eight-instance"
    }
  }
}




/*  Create Autoscaling Group  */
#----------------------------#
resource "aws_autoscaling_group" "eight-ASG" {
  #availability_zones = [var.availability_zone[0], var.availability_zone[1]]
  vpc_zone_identifier = [aws_subnet.eight-private-subnet1.id, aws_subnet.eight-private-subnet2.id]
  desired_capacity   = 2
  max_size           = 2
  min_size           = 2

  launch_template {
    id      = aws_launch_template.eight-Launch-Temp.id
    #version = "$Latest"
  }

  #depends_on = [aws_launch_template.eight-Launch-Temp]
}











# /*  Create Launch Template  */
# #----------------------------#

# resource "aws_launch_template" "foo" {
#   name = "foo"

#   block_device_mappings {
#     device_name = "/dev/sda1"

#     ebs {
#       volume_size = 20
#     }
#   }

#   capacity_reservation_specification {
#     capacity_reservation_preference = "open"
#   }

#   cpu_options {
#     core_count       = 4
#     threads_per_core = 2
#   }

#   credit_specification {
#     cpu_credits = "standard"
#   }

#   disable_api_stop        = true
#   disable_api_termination = true

#   ebs_optimized = true

#   elastic_gpu_specifications {
#     type = "test"
#   }

#   elastic_inference_accelerator {
#     type = "eia1.medium"
#   }

#   iam_instance_profile {
#     name = "test"
#   }

#   image_id = "ami-test"

#   instance_initiated_shutdown_behavior = "terminate"

#   instance_market_options {
#     market_type = "spot"
#   }

#   instance_type = "t2.micro"

#   kernel_id = "test"

#   key_name = "test"

#   license_specification {
#     license_configuration_arn = "arn:aws:license-manager:eu-west-1:123456789012:license-configuration:lic-0123456789abcdef0123456789abcdef"
#   }

#   metadata_options {
#     http_endpoint               = "enabled"
#     http_tokens                 = "required"
#     http_put_response_hop_limit = 1
#     instance_metadata_tags      = "enabled"
#   }

#   monitoring {
#     enabled = true
#   }

#   network_interfaces {
#     associate_public_ip_address = true
#   }

#   placement {
#     availability_zone = "us-west-2a"
#   }

#   ram_disk_id = "test"

#   vpc_security_group_ids = ["sg-12345678"]

#   tag_specifications {
#     resource_type = "instance"

#     tags = {
#       Name = "test"
#     }
#   }

#   user_data = filebase64("${path.module}/example.sh")
# }