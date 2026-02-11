variable "ami" {
  description = "AMI ID for EC2"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID where EC2 will be created"
  type        = string
}

variable "security_group_id" {
  description = "Security Group ID"
  type        = string
}

variable "key_name" {
  description = "AWS Key Pair Name"
  type        = string
}

variable "instance_name" {
  description = "Name tag for EC2"
  type        = string
}
