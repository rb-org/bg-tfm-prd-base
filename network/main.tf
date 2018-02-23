data "aws_availability_zones" "available" {}

locals {
  private_subnets = ["${
    slice(list(
      cidrsubnet(var.vpc_cidr, 8, 101),
      cidrsubnet(var.vpc_cidr, 8, 102),
      cidrsubnet(var.vpc_cidr, 8, 103),
      cidrsubnet(var.vpc_cidr, 8, 104),
      cidrsubnet(var.vpc_cidr, 8, 105),
      cidrsubnet(var.vpc_cidr, 8, 106),
    ), 0, (var.az_count))
  }"]

  public_subnets = ["${
    slice(list(
      cidrsubnet(var.vpc_cidr, 8, 1),
      cidrsubnet(var.vpc_cidr, 8, 2),
      cidrsubnet(var.vpc_cidr, 8, 3),
      cidrsubnet(var.vpc_cidr, 8, 4),
      cidrsubnet(var.vpc_cidr, 8, 5),
      cidrsubnet(var.vpc_cidr, 8, 6),
    ), 0, (var.az_count))
  }"]
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "1.23.0"

  name = "${var.name_prefix}-${terraform.workspace}"
  cidr = "${var.vpc_cidr}"

  azs                  = "${slice(data.aws_availability_zones.available.names,0,var.az_count)}"
  public_subnets       = ["${local.public_subnets}"]
  private_subnets      = ["${local.private_subnets}"]
  enable_nat_gateway   = true
  enable_vpn_gateway   = false
  enable_dns_hostnames = true
  enable_s3_endpoint   = true
  external_nat_ip_ids  = ["${aws_eip.nat.*.id}"]
  tags = "${merge(var.default_tags, 
      map("Environment", format("%s", var.environment)), 
      map("Workspace", format("%s", terraform.workspace)),
      map("Name", format("%s-vpc", var.name_prefix))
      )
    }"
}

resource "aws_eip" "nat" {
  count = "${var.az_count}"
  vpc   = true
}
