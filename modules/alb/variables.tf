variable "alb_name" {
  description = "Name of ALB"
  type        = string
}

variable "subnet_ids" {
  description = "List of Subnet IDs"
  type        = list(string)
}

variable "security_group_id" {
  description = "Security Group ID"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}
