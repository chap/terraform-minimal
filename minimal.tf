terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.20.0"
    }
  }
  required_version = ">= 1.1"
}

resource "aws_route53_zone" "deploy_sandbox" {
  name     = "deploy-2.sandbox.msap.io"
}

locals {
  timestamp = formatdate("YYYY-MM-DDThh:mm:ssZ", timestamp())
}

resource "aws_route53_record" "smoketest_txt" {
  zone_id = aws_route53_zone.deploy_sandbox.zone_id
  name = ""
  type = "TXT"
  ttl = 60

  records = [
    "${local.timestamp}"
  ]
}
