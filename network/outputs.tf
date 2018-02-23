# VPC
output "vpc_id" {
  description = "The ID of the VPC"
  value       = "${module.vpc.vpc_id}"
}

# Subnets
output "private_subnet_ids" {
  description = "List of IDs of private subnets"
  value       = ["${module.vpc.private_subnets}"]
}

output "private_subnet_cidrs" {
  value = ["${module.vpc.private_subnets_cidr_blocks}"]
}

output "public_subnet_ids" {
  description = "List of IDs of public subnets"
  value       = ["${module.vpc.public_subnets}"]
}

output "public_subnet_cidrs" {
  value = ["${module.vpc.public_subnets_cidr_blocks}"]
}
