terraform {
  backend "s3" {
    bucket = "terraform-tfstate-20230717"
    key    = "terraform.tfstate"
    region = "ap-northeast-1"
  }

  required_version = ">=1.4.6"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region  = "ap-northeast-1"
}

