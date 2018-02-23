provider "aws" {
  version                 = "~> 1.9.0"
  region                  = "${var.region}"
  shared_credentials_file = "~/.aws/credentials"
}

locals {
  env = "${terraform.workspace}"
}

module "network" {
  source = "./network/"

  vpc_cidr     = "${var.vpc_cidr}"
  region       = "${var.region}"
  name_prefix  = "${var.name_prefix}"
  environment  = "${var.environment}"
  az_count     = "${var.az_count}"
  default_tags = "${var.default_tags}"
}
