# Define the AWS region where resources will be created
variable "aws_region" {
  description = "The AWS region where resources will be deployed"
  default     = "us-east-1"
}

# Define the AMI to use for the EC2 instance
variable "ami_id" {
  description = "The AMI ID to use for the EC2 instance"
  type        = string
  default     = "ami-0427090fd1714168b"
}

# Define the EC2 instance type (e.g., t2.micro)
variable "instance_type" {
  description = "The EC2 instance type"
  type        = string
  default     = "t2.micro"
}

# Define a variable for the ECR repository name for MySQL
variable "mysql_ecr_repo_name" {
  description = "Name of the ECR repository for the MySQL Docker image"
  type        = string
  default     = "my-sql-image"
}

# Define a variable for the ECR repository name for the app
variable "app_ecr_repo_name" {
  description = "Name of the ECR repository for the application Docker image"
  type        = string
  default     = "my-app-image"
}

variable "vpc_id" {
  description = "The ID of the VPC where the subnet will be created"
  default     = "vpc-0070fe86896782f69"
  type        = string
}
variable "cidr_block" {
  description = "The CIDR block for the subnet"
  default     = "172.31.0.0/20"
  type        = string
}

variable "az" {
  description = "The availability zone where the subnet will be created"
  default     = "us-east-1a"
  type        = string
}