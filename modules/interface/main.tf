resource "aws_network_interface" "server-nic" {
  subnet_id       = var.subnet_id
  private_ips     = var.private_ips
  security_groups = var.security_groups
}