resource "aws_instance" "this" {
  ami                    = var.ami
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [var.security_group_id]
  key_name               = var.key_name

  user_data = <<-EOF
              #!/bin/bash
              apt update -y
              apt install httpd -y
              systemctl start httpd
              systemctl enable httpd
              echo "<h1>EC2 Created using Terraform</h1>" > /var/www/html/index.html
              EOF

  tags = {
    Name = var.instance_name
  }
}
