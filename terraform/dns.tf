resource "aws_route53_zone" "domain-public-zone" {
  name = var.domain_name
  comment = "${var.domain_name} public zone"
}

resource "aws_route53_record" "server1-record" {
  zone_id = aws_route53_zone.domain-public-zone.zone_id
  name    = var.domain_name
  type    = "A"
  ttl     = "300"
  records = [aws_eip.remote-dev-box-eip.public_ip]
}
