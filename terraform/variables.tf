variable "env_vars" {
  type = object({
    aws_access_key_id = string
    aws_secret_access_key = string
    aws_region = string
  })
}

variable "instance" {
  type = object({
    ami = string
    type = string
  })
}

variable "ssh_key_name" {
  type = string
}

variable "open_ports" {
  type = list(object({
    description = string
    port = number
    cidr_blocks = list(string)
  }))
}

variable "domain_name" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "igw_id" {
  type = string
}