module "vpc" {
  source = "./modules/vpc"
}

module "subnet" {
  source            = "./modules/subnet"
  vpc_id            = module.vpc.vpc_id
  subnet_prefix     = var.subnet_prefix
  availability_zone = var.availability_zone
  route_table_id    = module.vpc.route_table_id
}

module "security_group" {
  source = "./modules/security_group"
  vpc_id = module.vpc.vpc_id
}

module "interface" {
  source          = "./modules/interface"
  subnet_id       = module.subnet.subnet_id
  private_ips     = [var.private_ip]
  security_groups = [module.security_group.sg_id]
}

module "eip" {
  source            = "./modules/eip"
  network_interface = module.interface.network_interface_id
  private_ip        = var.private_ip
  depends_on        = [module.vpc.my-gw, module.instance.app-instance]
}

module "instance" {
  source               = "./modules/instance"
  ami                  = var.ami
  instance_type        = var.instance_type
  availability_zone    = var.availability_zone
  s3_file_url          = var.s3_file_url
  network_interface_id = module.interface.network_interface_id
}