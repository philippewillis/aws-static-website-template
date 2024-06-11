variable "app_name" {}
variable "app_version" {}

variable hosted_zone_name {}
variable env_tag {}
variable "sub_domain" {}


variable "region" {
  description = "The AWS region"
  default     = "us-west-2"
}


locals {
  bucket_name = "${var.app_name}-${terraform.workspace}"
  domain_name = "${var.sub_domain}${var.hosted_zone_name}"
}