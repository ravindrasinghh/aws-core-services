#AWS PROVIDER
provider "aws" {
  profile = "gce-veryme-vodafone-dev"
  region  = "${var.region}"
  version = "~> 2.12"
}