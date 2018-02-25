variable "region" {}

variable "name_prefix" {
  default = "bg"
}

variable "acc_id" {}

variable "vpc_cidr" {}

variable "az_count" {}

variable "environment" {}

variable "default_tags" {
  description = "Map of tags to add to all resources"
  type        = "map"

  default = {
    Terraform          = "true"
    GitHubRepo         = "bg-tfm-prd-base"
    GitHubOrganization = "rb-org"
  }
}
