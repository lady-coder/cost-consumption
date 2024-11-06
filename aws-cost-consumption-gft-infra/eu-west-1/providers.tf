terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }


  }
  backend "s3" {
    bucket = "gftcostconsumptions3"
    key    = "eu-west-1/terraform.tfstate"
    region = "eu-west-2"
  }
}

# Configure the AWS Provider
provider "aws" {
  region = var.region
}