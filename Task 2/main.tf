terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

#Create IAM Role for ECR
resource "aws_iam_role" "ecr_role" {
  name = "ecr_access_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_instance_profile" "ecr_instance_profile" {
  name = "ecr_profile"
  role = "${aws_iam_role.ecr_role.name}"
}

resource "aws_iam_policy_attachment" "ecr_policy_attachment" {
  name = "ecr_reading_policy"
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly" 
  roles      = [aws_iam_role.ecr_role.name]
}


#Create AWS Instance#
resource "aws_instance" "Blogapp_EC2_Instance" {
  ami           = var.ami
  instance_type = var.instance_type

  iam_instance_profile = aws_iam_instance_profile.ecr_instance_profile.name

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              amazon-linux-extras install docker -y
              systemctl start docker
              systemctl enable docker

              # Authenticate Docker with your ECR repository
              aws ecr get-login-password --region var.region | docker login --username AWS --password-stdin var.ecr_repository

              # Pull and run your Docker image from ECR
              docker run -d -p 8080:3000 var.ecr_repository/BlogApp:latest
              EOF

  network_interface {
    network_interface_id = var.network_interface_id
    device_index         = 0
  }
}
