terraform {
  backend "s3" {
    region = "us-west-2"
  }
  required_version = ">= 1.7.5"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.4"
    }
  }
}

provider "aws" {
  region = var.region
}