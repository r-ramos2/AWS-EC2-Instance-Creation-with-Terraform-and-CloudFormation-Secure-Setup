# main.tf

# Security group with restricted access
resource "aws_security_group" "ec2_security_group" {
  name        = "ec2_security_group"
  description = "Security group for EC2 instance allowing SSH access"

  # Allow SSH access from a specific IP only
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.my_ip]  # Your IP address for SSH access
  }

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# EC2 instance
resource "aws_instance" "my_ec2" {
  ami             = var.ami_id
  instance_type   = var.instance_type
  key_name        = var.key_pair_name
  security_groups = [aws_security_group.ec2_security_group.name]

  tags = {
    Name = "MyEC2Instance"
  }
}
