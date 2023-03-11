
/*  Create Application Load Balancer   */
#---------------------------------------#

resource "aws_lb" "eight-alb" {
  name               = "eight-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.eight-alb-sg.id]
  subnets            = [aws_subnet.eight-public-subnet1.id, aws_subnet.eight-public-subnet2.id]
}



/*  Create Target group */
#------------------------#

resource "aws_lb_target_group" "eight-target" {
  name     = "eight-target"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.eight-vpc.id
}


/*  Attach (ASG) to the target group   */
#---------------------------------------#
resource "aws_autoscaling_attachment" "asg_attachment_bar" {
  autoscaling_group_name = aws_autoscaling_group.eight-ASG.id
  lb_target_group_arn    = aws_lb_target_group.eight-target.arn
}



/*  Create Listener to check for connection requests on port 80.  */
#------------------------------------------------------------------#

resource "aws_lb_listener" "eight-listener" {
  load_balancer_arn = aws_lb.eight-alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.eight-target.arn
  }
}



