provider "aws" {
region = var.region
}

resource "aws_instance" "frontend" {
ami = "ami-0c02fb55956c7d316" # Amazon Linux 2
instance_type = "t3.micro"
key_name = var.key_name
tags = {
Name = "c8.local"
}
}

resource "aws_instance" "backend" {
ami = "ami-08c40ec9ead489470" # Ubuntu 21.04
instance_type = "t3.micro"
key_name = var.key_name
tags = {
Name = "u21.local"
}
}
