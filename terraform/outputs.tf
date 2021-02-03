output "instance_public_dns" {
  value = aws_eip.remote-dev-box-eip.public_dns
}

output "instance_public_ip" {
  value = aws_eip.remote-dev-box-eip.public_ip
}
