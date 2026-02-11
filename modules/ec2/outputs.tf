output "instance_id" {
  description = "EC2 Instance ID"
  value       = aws_instance.this.id
}

output "public_ip" {
  description = "Public IP of EC2"
  value       = aws_instance.this.public_ip
}
