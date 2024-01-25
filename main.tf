# In another Region:
# 1. Create 2 ec2-instances (app_server and db_server)
# 2. Create 1 VPC and 1 subnet in that VPC
# 3. Create 1 security group
# 4. Push the project to a github repository. Name it as you like

# START SCRIPT FROM HERE

# Configure the AWS Provider
provider "aws" {
  region  = "us-east-2"

}

resource "aws_instance" "app_server" {
  ami = "ami-0a3c3a20c09d6f377"
  instance_type = "t2.medium"
  key_name = "java-app-key"

  tags = {
    Name = "app_server"
  }

}

resource "aws_instance" "db_server" {
  ami = "ami-0a3c3a20c09d6f377"
  instance_type = "t2.medium"
  key_name = "java-app-key"
  
  tags = {
    Name = "db_server"
  }
}

# Create a VPC
resource "aws_vpc" "app_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "vpc-1"
  }
}

# Create subnet
resource "aws_subnet" "app_subnet" {
  vpc_id     = aws_vpc.app_vpc.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "subnet-1"
  }
}

resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.app_vpc.id

  ingress = []
  egress  = []
  # ingress {
  #   description      = "TLS from VPC"
  #   from_port        = 443
  #   to_port          = 443
  #   protocol         = "tcp"
  #   cidr_blocks      = [aws_vpc.app_vpc.cidr_block]
  #   ipv6_cidr_blocks = [aws_vpc.app_vpc.ipv6_cidr_block]
  # }

  # egress {
  #   from_port        = 0
  #   to_port          = 0
  #   protocol         = "-1"
  #   cidr_blocks      = ["0.0.0.0/0"]
  #   ipv6_cidr_blocks = ["::/0"]
  # }

  tags = {
    Name = "allow_tls"
  }
}