terraform {
  required_version = ">= 1.1"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.20.0"
    }
  }
}

resource "aws_route53_zone" "deploy_sandbox" {
  name = "deploy-tf-smoketest.build-dev.msap.io"
}

resource "aws_route53_record" "smoketest_txt" {
  zone_id = aws_route53_zone.deploy_sandbox.zone_id
  name    = ""
  type    = "TXT"
  ttl     = 5

  records = [
    timestamp()
  ]
}
