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
  region  = "eu-west-2" #
}

resource "aws_instance" "remote-dev-box" {
  ami           = "ami-0e80a462ede03e653" # Amazon Linux 2 AMI (HVM), SSD Volume Type - ami-0e80a462ede03e653 (64-bit x86)
  instance_type = "t2.micro"
  key_name      = "remote-dev-box"
  user_data     = file("user_data.sh")

  provisioner "file" {
    source      = "code-shell.sh"
    destination = "/home/ec2-user/code-shell.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /home/ec2-user/code-shell.sh",
    ]
  }
}

output "instance_public_dns" {
  value = aws_instance.remote-dev-box.public_dns
}

output "instance_public_ip" {
  value = aws_instance.remote-dev-box.public_ip
}

