# Output the public IP of the EC2 instance
output "ec2_instance_public_ip" {
  value       = aws_instance.web_app_instance.public_ip
  description = "The public IP of the EC2 instance"
}

# Output the ECR repository URL for MySQL
output "mysql_ecr_repository_url" {
  value       = aws_ecr_repository.mysql_ecr_repo.repository_url
  description = "The URL of the MySQL ECR repository"
}

# Output the ECR repository URL for the application
output "app_ecr_repository_url" {
  value       = aws_ecr_repository.app_ecr_repo.repository_url
  description = "The URL of the Application ECR repository"
}

# Output the security group ID
output "ec2_security_group_id" {
  value       = aws_security_group.ec2_security_group.id
  description = "The ID of the security group for the EC2 instance"
}
