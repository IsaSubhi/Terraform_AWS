#---------------SUBNET---------------
resource "aws_subnet" "my-subnet" {
  vpc_id            = var.vpc_id
  cidr_block        = var.subnet_prefix
  availability_zone = var.availability_zone
  tags = {
    Name = "My Subnet"
  }
}

#---------------TableAssociation---------------
resource "aws_route_table_association" "my-rta" {
  subnet_id      = aws_subnet.my-subnet.id
  route_table_id = var.route_table_id
}