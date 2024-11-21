# variables.tf

variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"  # Change to your desired region
}

variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  type        = string
  default     = "ami-xxxxxxxxxxxxxxxxxxx"  # Amazon Linux 2 AMI for us-east-1 (update for your region)
}

variable "instance_type" {
  description = "Type of EC2 instance"
  type        = string
  default     = "t2.micro"  # Free tier eligible instance type
}

variable "key_pair_name" {
  description = "Name of the existing key pair"
  type        = string
  default     = "my-key-pair"  # Replace with your actual key pair name
}

variable "my_ip" {
  description = "Your IP address for SSH access"
  type        = string
  default     = "0.0.0.0/0"  # Replace 0.0.0.0/0 with your IP (e.g., "203.0.113.0/32") for better security
}
