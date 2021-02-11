locals {
  reuseVPC = var.vpc_id != "false"
}

resource "aws_vpc" "remote-dev-box-vpc" {
  count = local.reuseVPC ? 0 : 1

  cidr_block = "10.1.0.0/16"

  tags = {
    Name = var.ssh_key_name
  }
}

resource "aws_internet_gateway" "remote-dev-box-igw" {
  count = local.reuseVPC ? 0 : 1

  vpc_id = aws_vpc.remote-dev-box-vpc[0].id

  tags = {
    Name = var.ssh_key_name
  }
}

resource "aws_subnet" "remote-dev-box-subnet" {
  vpc_id = local.reuseVPC ? var.vpc_id : aws_vpc.remote-dev-box-vpc[0].id
  cidr_block = "10.1.0.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name = var.ssh_key_name
  }
}

resource "aws_route_table" "remote-dev-box-subnet-rt" {
  vpc_id = local.reuseVPC ? var.vpc_id : aws_vpc.remote-dev-box-vpc[0].id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = local.reuseVPC ? var.igw_id : aws_internet_gateway.remote-dev-box-igw[0].id
  }

  tags = {
    Name = var.ssh_key_name
  }
}

resource "aws_route_table_association" "remote-dev-box-subnet-rta" {
  subnet_id = aws_subnet.remote-dev-box-subnet.id
  route_table_id = aws_route_table.remote-dev-box-subnet-rt.id
}

resource "aws_security_group" "remote-dev-box-sg" {
  description = "Remote dev box security group"
  vpc_id = local.reuseVPC ? var.vpc_id : aws_vpc.remote-dev-box-vpc[0].id

  dynamic "ingress" {
    for_each = var.open_ports
    content {
      description = ingress.value.description
      from_port   = ingress.value.port
      to_port     = ingress.value.port
      protocol    = "tcp"
      cidr_blocks = ingress.value.cidr_blocks
    }
  }

  egress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.ssh_key_name
  }
}

resource "aws_instance" "remote-dev-box" {
  ami           = var.instance.ami
  instance_type = var.instance.type
  key_name      = var.ssh_key_name

  root_block_device {
    volume_size = 20
  }

  vpc_security_group_ids = [aws_security_group.remote-dev-box-sg.id]
  subnet_id = aws_subnet.remote-dev-box-subnet.id

  tags = {
    Name = var.ssh_key_name
  }
}

resource "aws_eip" "remote-dev-box-eip" {
  instance = aws_instance.remote-dev-box.id
  vpc      = true

  tags = {
    Name = var.ssh_key_name
  }
}