terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
    }
  }

  backend "s3" {
    bucket = "aram-dasmeta-task-state"
    region = "eu-north-1"
    key = "terraform.tfstate"
  }
}

provider "aws" {
  region = "eu-north-1"
  profile = "default"
}