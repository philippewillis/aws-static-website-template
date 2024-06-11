variable "app_name" {}
variable "app_version" {}

variable hosted_zone_name {}
variable env_tag {}
variable "suffix" {}


variable "region" {
  description = "The AWS region"
  default     = "us-west-2"
}


locals {
  bucket_name = "${var.app_name}-${terraform.workspace}"
}