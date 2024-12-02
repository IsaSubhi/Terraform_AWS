variable "private_ip" {
  description = "Private IPv4 address of instance"
  default     = "10.0.1.20"
}

variable "availability_zone" {
  description = "Region's availability zone"
  default     = ""
}

variable "instance_type" {
  description = "Instance type"
  default     = "t3.micro"
}

variable "ami" {
  description = "Region's Ubuntu AMI ID"
  default     = ""
}

variable "s3_file_url" {
  description = "The full URL of the HTML file in S3"
  default     = ""
}

variable "subnet_prefix" {
  description = "cidr block for the subnet"
  default     = "10.0.1.0/24"
}
