terraform {
    required_providers {
      aws = {
        source = "hashicorp/aws"
        version = "~> 4.16"
      }
    }
}

provider "aws" {
  region = "eu-west-1"
}

resource "aws_instance" "app_server" {
    ami                     = "ami-0b752bf1df193a6c4"
    instance_type           = "t2.micro"
  

  tags = {
    "Name" = "First_Terraform_AWS"
  }
}