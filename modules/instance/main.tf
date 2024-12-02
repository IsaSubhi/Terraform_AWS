resource "aws_instance" "app-instance" {
  ami               = var.ami
  instance_type     = var.instance_type
  availability_zone = var.availability_zone
  network_interface {
    device_index         = 0
    network_interface_id = var.network_interface_id
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