terraform {
  #  required_version = "0.11.2"

  backend "s3" {
    bucket  = "bg-tfm-state"
    region  = "eu-west-1"
    key     = "bg-base.tfstate"
    encrypt = "true"
  }
}

// Remote state from common plan
data "terraform_remote_state" "common" {
  backend = "s3"

  config {
    region = "${var.region}"
    bucket = "bg-tfm-state"
    key    = "bg-common.tfstate"
  }
}
