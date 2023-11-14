## CREATE ACM
module "acm" {
  source = "../../../modules/security/acm/dns-validation"
  default_tags = var.default_tags
  dns_name = var.dns_name
  domain_name = var.domain_names[0]
  domain_names = var.domain_names
  region = var.region
}