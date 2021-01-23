terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 2.70"
    }
  }
}

provider "aws" {
  profile = "default"
  region  = "eu-west-2"
}

resource "aws_security_group" "remote-dev-box-sg" {
  name        = "remote-dev-box-sg"
  description = "Remote dev box security group"

  egress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
  }

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
}

# data "template_file" "user_data" {
#   template = file("scripts/cloud-init.yaml")
# }

resource "aws_instance" "remote-dev-box" {
  ami           = "ami-0e80a462ede03e653" # Amazon Linux 2 AMI (HVM), SSD Volume Type - ami-0e80a462ede03e653 (64-bit x86)
  instance_type = "t2.micro"
  key_name      = "remote-dev-box"
  # user_data     = data.template_file.user_data.rendered

  root_block_device {
    volume_size = 20
  }

  vpc_security_group_ids = [aws_security_group.remote-dev-box-sg.id]
}

resource "aws_eip" "remote-dev-box-eip" {
  instance = aws_instance.remote-dev-box.id
  vpc      = true
}

output "instance_public_dns" {
  value = aws_eip.remote-dev-box-eip.public_dns
}

output "instance_public_ip" {
  value = aws_eip.remote-dev-box-eip.public_ip
}
