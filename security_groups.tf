/*  Create Security Group for instances to allow traffic only from ALB  */
#------------------------------------------------------------------------#

resource "aws_security_group" "eight-instances-sg" {
  name = "instances-sg"  
  description = "Allow traffic from ALB"
  vpc_id      = aws_vpc.eight-vpc.id

  ingress {
    description     = "ALB traffic"
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.eight-alb-sg.id]   # replace with sg of ALB when created.
    cidr_blocks = [var.vpc_cidr]
  }

   ingress {
    description     = "ALB traffic"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.eight-alb-sg.id]   # replace with sg of ALB when created.
    #cidr_blocks = [var.vpc_cidr]
  }


  ingress {
    description     = "ALB traffic"
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    security_groups = [aws_security_group.eight-alb-sg.id]   # replace with sg of ALB when created.
    cidr_blocks = [var.vpc_cidr]
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "EIGHT_Instance_SG"
  }
}



/*  Create Security Group for ALB  */
#-----------------------------------#

resource "aws_security_group" "eight-alb-sg" {
  name        = "Eight_ALB-sg"
  description = "Allow web inbound traffic"
  vpc_id      = aws_vpc.eight-vpc.id

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "EIGHT_ALB_SG"
  }
}
