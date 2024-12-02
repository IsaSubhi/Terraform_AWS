# Welcome to my Terraform AWS Project
## Overview
This project automates the deployment of a web application using AWS and Terraform. The web application consists of a simple HTML file that once uploaded to a S3 bucket, is made accessible to users via an Apache server hosted on an EC2 instance.

![image](https://github.com/user-attachments/assets/b90e83b6-e22f-43a0-962d-921445dbb233)

### Components:
- S3 Storage for the webapp files:
  - The project uses an AWS S3 bucket as the initial storage location for the web application's HTML file.
  - The HTML file is then copied to the instance Apache Server folder to view the content from any browser.
- Infrastructure as Code with Terraform:
  - Terraform is used to automate the infrastructure provisioning, creating a cluster on AWS that is made of: VPC, Gateway, Route Table, Subnet, Table Association, Security Group, Network Interface, Elastic IP and a EC2 ubuntu instance
  - It configures an instance with the necessary settings to host an Apache server.
- End-to-End Automation:
  - The entire deployment process, from setting up the EC2 instance to configuring Apache and transferring the HTML file, is automated through Terraform.
  - This setup provides a seamless way to deploy and view static HTML content on AWS infrastructure which can be expanded to host multiple instances or serve multiple files with minimal manual intervention.

### Requirements:
- AWS Account with permissions to manage S3, EC2, and IAM roles.
- [Install Terraform](https://developer.hashicorp.com/terraform/install) locally.
- The web application files to upload to the S3 bucket.

### How to Use:
1. Upload HTML File to the designated S3 bucket.
2. Add the provider's information in the [provider](./provider.tf) file.
3. Enter the missing default information for the variables in the [variables](./variables.tf) file
4. Initialize the working directory: downloads the necessary provider plugins and modules and setting up the backend for storing your infrastructure's state. 
```
terraform init
```
5. Execute a plan to creates a dry-run: determining what actions are necessary to achieve the desired state defined in the Terraform configuration files.
```
terraform plan
```
6. Apply the planned actions: applies the changes required to reach the desired state of the configuration, creating, modifying, or deleting the infrastructure resources as necessary.
```
terraform apply
```
7. Preview your web app in the browser via the public IPv4 address
8. Terminates resources managed by your Terraform project:
```
terraform destroy
```
