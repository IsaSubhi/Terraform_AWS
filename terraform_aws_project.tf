provider "aws" {
  access_key = ""
  secret_key = ""
  region     = ""
}
#---------------VPC---------------
resource "aws_vpc" "my-vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "My VPC"
  }
}

#---------------GATEWAY---------------
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

#---------------SUBNET---------------
resource "aws_subnet" "my-subnet" {
  vpc_id            = aws_vpc.my-vpc.id
  cidr_block        = var.subnet_prefix
  availability_zone = var.availability_zone
  tags = {
    Name = "My Subnet"
  }
}

#---------------TableAssociation---------------
resource "aws_route_table_association" "my-rta" {
  subnet_id      = aws_subnet.my-subnet.id
  route_table_id = aws_route_table.my-route-table.id
}

#---------------SecurityGroup---------------
resource "aws_security_group" "allow-web" {
  name   = "allow-web-traffic"
  vpc_id = aws_vpc.my-vpc.id
  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
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
    Name = "Allow Traffic"
  }
}

#---------------NetworkInterface---------------
resource "aws_network_interface" "server-nic" {
  subnet_id       = aws_subnet.my-subnet.id
  private_ips     = [var.private_ip]
  security_groups = [aws_security_group.allow-web.id]
}

#---------------ElasticIP---------------
resource "aws_eip" "static_ip" {
  domain                    = "vpc"
  network_interface         = aws_network_interface.server-nic.id
  associate_with_private_ip = var.private_ip
  depends_on                = [aws_internet_gateway.my-gw, aws_instance.app-instance]
  tags = {
    Name = "Web Server EIP"
  }
}

#---------------INSTANCE---------------
resource "aws_instance" "app-instance" {
  ami               = var.ami
  instance_type     = var.instance_type
  availability_zone = var.availability_zone
  network_interface {
    device_index         = 0
    network_interface_id = aws_network_interface.server-nic.id
  }

  user_data = <<-EOF
    #!/bin/bash
    # Update and install Apache
    apt update -y
    apt install -y apache2
    # Start Apache service
    systemctl start apache2
    systemctl enable apache2
    # Download the HTML file from the S3 bucket using curl
    curl -o /var/www/html/index.html ${var.s3_file_url}
    # Restart Apache to load the new file
    systemctl restart apache2
  EOF

  tags = {
    Name = "Ubuntu Apache Instance"
  }
}

