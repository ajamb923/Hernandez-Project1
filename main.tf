/*  DEMO: Create 3 tier Infrastructure w/ALB */
#---------------------------------------------#

#
#
#
#
#


/*  Create VPC   */
#-----------------#

resource "aws_vpc" "eight-vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = "true"
  tags = {
    Name = "EIGHT-VPC"
  }
}

/*  Create IGW  */
#----------------#

resource "aws_internet_gateway" "eight-IGW" {
  vpc_id = aws_vpc.eight-vpc.id

  tags = {
    Name = "EIGHT-IGW"
  }
}


/*  Create a Public Subnets  */
#-----------------------------#
resource "aws_subnet" "eight-public-subnet1" {
  vpc_id            = aws_vpc.eight-vpc.id
  cidr_block        = var.public_subnet_cidr[0]
  availability_zone = var.availability_zone[0]
  map_public_ip_on_launch = true

  tags = {
    Name = "eight-public-subnet"
  }
}

resource "aws_subnet" "eight-public-subnet2" {
  vpc_id            = aws_vpc.eight-vpc.id
  cidr_block        = var.public_subnet_cidr[1]
  availability_zone = var.availability_zone[1]
  map_public_ip_on_launch = true

  tags = {
    Name = "eight-public-subnet"
  }
}


/*  Create Public Route Table  */
#--------------------------------#

#---Public Route Table
resource "aws_route_table" "eight-public-route-table" {
  vpc_id = aws_vpc.eight-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.eight-IGW.id
  }

  tags = {
    Name = "EIGTH_PUB_RT"
  }
}






/*  Create a Private Subnets  */
#-----------------------------#

#----------- Private Subnets------------------#
resource "aws_subnet" "eight-private-subnet1" {
  vpc_id            = aws_vpc.eight-vpc.id
  cidr_block        = var.private_subnet_cidr[0]
  availability_zone = var.availability_zone[0]
  map_public_ip_on_launch = false

  tags = {
    Name = "eight-private-subnet1"
  }
}

resource "aws_subnet" "eight-private-subnet2" {
  vpc_id            = aws_vpc.eight-vpc.id
  cidr_block        = var.private_subnet_cidr[1]
  availability_zone = var.availability_zone[1]
  map_public_ip_on_launch = false

  tags = {
    Name = "eight-private-subnet2"    # Name = "${var.name}-private-sg"
  }
}


/*  Create Private Route Table  */
#--------------------------------#

#---Private Route Table 1
resource "aws_route_table" "eight-private-route-table1" {
  vpc_id = aws_vpc.eight-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.eight_NAT.id
  }

  tags = {
    Name = "EIGTH_PRIV-RT-1"
  }
}


#---Private Route Table 2
resource "aws_route_table" "eight-private-route-table2" {
  vpc_id = aws_vpc.eight-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.eight_NAT.id
  }

  tags = {
    Name = "EIGTH_PRIV-RT-1"
  }
}



/*  Associate subnets with Route Table  */
#----------------------------------------#

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.eight-private-subnet1.id
  route_table_id = aws_route_table.eight-private-route-table1.id
}

resource "aws_route_table_association" "b" {
  subnet_id      = aws_subnet.eight-private-subnet2.id
  route_table_id = aws_route_table.eight-private-route-table2.id
}

resource "aws_route_table_association" "c" {
  subnet_id      = aws_subnet.eight-public-subnet1.id
  route_table_id = aws_route_table.eight-public-route-table.id
}

resource "aws_route_table_association" "d" {
  subnet_id      = aws_subnet.eight-public-subnet2.id
  route_table_id = aws_route_table.eight-public-route-table.id
}



/*  Create VPC Endpoint for SSM connectivity - ssm & ssmmessages  */
#------------------------------------------------------------------#
resource "aws_vpc_endpoint" "ssm" {
  vpc_id            = aws_vpc.eight-vpc.id
  service_name      = "com.amazonaws.us-east-1.ssm"
  vpc_endpoint_type = "Interface"
  subnet_ids = [aws_subnet.eight-private-subnet1.id, aws_subnet.eight-private-subnet2.id]
  security_group_ids = [aws_security_group.eight-instances-sg.id]

  private_dns_enabled = true
}

resource "aws_vpc_endpoint" "ssmmessages" {
  vpc_id            = aws_vpc.eight-vpc.id
  service_name      = "com.amazonaws.us-east-1.ssmmessages"
  vpc_endpoint_type = "Interface"
  subnet_ids = [aws_subnet.eight-private-subnet1.id, aws_subnet.eight-private-subnet2.id]
  security_group_ids = [aws_security_group.eight-instances-sg.id]

  private_dns_enabled = true
}




/*  Elastic IP for Nat */
#-----------------------#
resource "aws_eip" "nat-eip" {
  vpc      = true
}



/*  Create NAT Gateway */
#-----------------------#
resource "aws_nat_gateway" "eight_NAT" {
  allocation_id = aws_eip.nat-eip.id
  subnet_id     = aws_subnet.eight-public-subnet1.id

  tags = {
    Name = "Eight_NAT"
  }
  
  depends_on = [aws_internet_gateway.eight-IGW]
}



