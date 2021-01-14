# The following file includes all the resources that are required for certificate
# for CloudFront distributiion.

# The first line is for zone that is already set up in Route 53

data "aws_route53_zone" "zone" {
  name         = "${local.alternate_domain_name}."
  private_zone = false

}
# Next is the resource for the certificate.
# Here I'm using DNS method  for validation.

resource "aws_acm_certificate" "cert" {
  domain_name       = local.primary_domain_name
  subject_alternative_names = [local.alternate_domain_name]
  validation_method = "DNS"
}

resource "aws_acm_certificate_validation" "cert" {
  certificate_arn         = aws_acm_certificate.cert.arn
  validation_record_fqdns = [
      "${aws_route53_record.cert_validation.fqdn}",
      "${aws_route53_record.cert_validation_alt1.fqdn}",
    ]
}

# The last two resources will create the DNS records needed in Route 53 for the validation.

resource "aws_route53_record" "cert_validation" {
  name    = aws_acm_certificate.cert.domain_validation_options.0.resource_record_name
  type    = aws_acm_certificate.cert.domain_validation_options.0.resource_record_type
  zone_id = data.aws_route53_zone.zone.id
  records = ["${aws_acm_certificate.cert.domain_validation_options.0.resource_record_value}"]
  ttl     = 60
}

resource "aws_route53_record" "cert_validation_alt1" {
  name    = aws_acm_certificate.cert.domain_validation_options.1.resource_record_name
  type    = aws_acm_certificate.cert.domain_validation_options.1.resource_record_type
  zone_id = data.aws_route53_zone.zone.id
  records = ["${aws_acm_certificate.cert.domain_validation_options.1.resource_record_value}"]
  ttl     = 60
}
