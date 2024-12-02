resource "aws_eip" "static_ip" {
  domain                    = "vpc"
  network_interface         = var.network_interface
  associate_with_private_ip = var.private_ip
  tags = {
    Name = "Web Server EIP"
  }
}
