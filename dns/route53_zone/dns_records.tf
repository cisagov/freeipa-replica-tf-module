#-------------------------------------------------------------------------------
# Create some DNS records.
#-------------------------------------------------------------------------------
resource "aws_route53_record" "A" {
  count = var.do_it ? 1 : 0

  zone_id = var.zone_id
  name    = var.hostname
  type    = "A"
  ttl     = var.ttl
  records = [
    var.ip,
  ]
}
