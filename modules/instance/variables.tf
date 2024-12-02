variable "ami" {
  description = "Region's Ubuntu AMI ID"
}

variable "instance_type" {
  description = "Instance type"
}


variable "availability_zone" {
  description = "Region's availability zone"
}

variable "s3_file_url" {
  description = "The full URL of the HTML file in S3"
  type        = string
}


variable "network_interface_id" {
  description = "Network Interface ID"
}