terraform {
  required_version = ">= 1.1"
  backend "pg" {
    conn_str = "postgres://username:password@postgres-terraform-state/postgres"
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.20.0"
    }
  }
}

resource "aws_route53_zone" "deploy_sandbox" {
  name     = "deploy-3.sandbox.msap.io"
}

locals {
  timestamp = formatdate("YYYY-MM-DDThh:mm:ssZ", timestamp())
}

resource "aws_route53_record" "smoketest_txt" {
  # zone_id = aws_route53_zone.deploy_sandbox.zone_id
  name = ""
  type = "TXT"
  ttl = 5

  records = [
    "${local.timestamp}"
  ]
}
