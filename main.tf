# VPC 
resource "aws_vpc" "practice_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "practice_vpc"
  }

}

# SUBNET
resource "aws_subnet" "sub" {
  vpc_id                  = aws_vpc.practice_vpc.id
  cidr_block              = "10.0.0.0/20"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    name = "public-sub"
  }
}

# INTERNET GATEWAY
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.practice_vpc.id

  tags = {
    name = "My-igw"
  }
}

# ROUTE-TABLE
resource "aws_route_table" "rt_1" {
  vpc_id = aws_vpc.practice_vpc.id

  tags = {
    name = "rt-1"
  }
}

# ROUTE
resource "aws_route" "route" {
  route_table_id         = aws_route_table.rt_1.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

# ROUTE-TABLE-ASSOCIATION 
resource "aws_route_table_association" "rta" {
  subnet_id      = aws_subnet.sub.id
  route_table_id = aws_route_table.rt_1.id

}

# SECURITY-GROUP 
resource "aws_security_group" "sg" {
  name   = "traffic"
  vpc_id = aws_vpc.practice_vpc.id

  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

# AWS-INSTANCE-EC2 (UBUNTU)
resource "aws_instance" "ec2_instance" {
  ami                    = "ami-0b6c6ebed2801a5cb"
  instance_type          = "t3.micro"
  key_name               = "terraform-key"
  vpc_security_group_ids = [aws_security_group.sg.id]
  subnet_id              = aws_subnet.sub.id
  user_data              = <<-EOF
          #!/bin/bash
          sudo -i
          apt update -y 
          apt install apache2 -y 
          systemctl start apache2
          systemctl enable apache2
          echo "Hello World! This side bhushan " > /var/www/html/index.html
          EOF


  tags = {
    name = "BM-Brand"
  }

}