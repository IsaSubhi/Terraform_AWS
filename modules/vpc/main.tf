#---------------VPC---------------
resource "aws_vpc" "my-vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "My VPC"
  }
}

#---------------Gateway---------------
resource "aws_internet_gateway" "my-gw" {
  vpc_id = aws_vpc.my-vpc.id
  tags = {
    Name = "My Gateway"
  }
}

#---------------RouteTable---------------
resource "aws_route_table" "my-route-table" {
  vpc_id = aws_vpc.my-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my-gw.id
  }
  route {
    ipv6_cidr_block = "::/0"
    gateway_id      = aws_internet_gateway.my-gw.id
  }
  tags = {
    Name = "My Route Table"
  }
}