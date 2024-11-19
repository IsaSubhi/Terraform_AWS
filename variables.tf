variable "ami" {
  description = "Region's Ubuntu AMI ID"
#  default     = ""
}

variable "instance_type" {
  description = "Instance type"
#  default = "t3.micro"
}


variable "availability_zone" {
  description = "Region's availability zone"
#  default     = "" 
}

variable "subnet_prefix" {
  description = "cidr block for the subnet"
#  default     = ""
}

variable "private_ip" {
  description = "Private IPv4 address of instance"
#  default     = ""
}

variable "s3_file_url" {
  description = "The full URL of the HTML file in S3"
#  default     = ""
  type        = string
}

