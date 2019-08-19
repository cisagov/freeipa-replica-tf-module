#-------------------------------------------------------------------------------
# Configure the Route53 zone modules
#-------------------------------------------------------------------------------
module "private_zone" {
  source = "./route53_zone"

  hostname = var.hostname
  ip       = var.private_ip
  ttl      = var.ttl
  zone_id  = var.private_zone_id
}

module "public_zone" {
  source = "./route53_zone"

  do_it    = var.associate_public_ip_address
  hostname = var.hostname
  ip       = var.public_ip
  ttl      = var.ttl
  zone_id  = var.public_zone_id
}
