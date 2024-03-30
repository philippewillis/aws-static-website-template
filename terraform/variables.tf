
variable hosted_zone_name {}
variable env_tag {}
variable "suffix" {}

variable "project_name" {
  default = ""
  type = string
}

variable "region" {
  description = "The AWS region"
  default     = "us-west-2"
}


locals {
  bucket_name = "${var.project_name}${var.suffix}"
}