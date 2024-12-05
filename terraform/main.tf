terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }
  required_version = ">= 1.2"
}
provider "aws" {
  region = "us-east-1"
}


resource "aws_subnet" "public_subnet" {
  vpc_id            = var.vpc_id
  cidr_block        = var.cidr_block
  availability_zone = var.az
  }


# Create the Security Group
resource "aws_security_group" "ec2_security_group" {
  name        = "ec2-security-group"
  description = "Allow inbound traffic for the EC2 instance"
  vpc_id      = var.vpc_id  # Associate with the default VPC

  # Allow inbound traffic on ports 8081, 8082, and 8083
  ingress {
    from_port   = 8081
    to_port     = 8081
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  ingress {
  from_port   = 22
  to_port     = 22
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8082
    to_port     = 8082
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8083
    to_port     = 8083
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "EC2 Security Group"
  }
}

# Create the EC2 instance
resource "aws_instance" "web_app_instance" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  key_name                    = aws_key_pair.Assignment1.key_name
  subnet_id                   = aws_subnet.public_subnet.id
  security_groups             = [aws_security_group.ec2_security_group.id]
  associate_public_ip_address = true

  tags = {
    Name = "Web App EC2 Instance"
  }
}

# Create the ECR repository for MySQL
resource "aws_ecr_repository" "mysql_ecr_repo" {
  name                 = var.mysql_ecr_repo_name 
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

# Create the ECR repository for the application
resource "aws_ecr_repository" "app_ecr_repo" {
  name                 = var.app_ecr_repo_name 
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "aws_key_pair" "Assignment1" {
  key_name   = "Assignment1"
  public_key = file("Assignment1.pub")
}
