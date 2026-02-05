provider "aws" {
  region = var.region
}

# 🔐 Security Group
resource "aws_security_group" "devops_sg" {
  name        = "devops-ci-sg"
  description = "Allow SSH, HTTP, Netdata"

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Netdata"
    from_port   = 19999
    to_port     = 19999
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

# 🖥 Frontend
resource "aws_instance" "frontend" {
  ami                    = "ami-0c02fb55956c7d316"
  instance_type          = "t3.micro"
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.devops_sg.id]

  tags = {
    Name = "c8.local"
  }
}

# 🖥 Backend
resource "aws_instance" "backend" {
  ami                    = "ami-08c40ec9ead489470"
  instance_type          = "t3.micro"
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.devops_sg.id]

  tags = {
    Name = "u21.local"
  }
}

# 📦 Auto-generate Ansible inventory
resource "local_file" "inventory" {
  filename = "${path.module}/../ansible/inventory.ini"

  content = <<EOT
[frontend]
${aws_instance.frontend.public_ip}

[backend]
${aws_instance.backend.public_ip}
EOT
}
