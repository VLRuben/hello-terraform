terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }
}

provider "aws" {
  region = "eu-west-1"
}
resource "aws_instance" "app_server" {
  ami                    = "ami-0b752bf1df193a6c4"
  instance_type          = "t2.micro"
  vpc_security_group_ids = ["sg-044606c174c5be948"]
  subnet_id              = "subnet-0b0a1fa61b7bf6868"

  key_name = "clave-lucatic"
  tags = {

    "Name" = var.instance_name
    "APP"  = "vue2048_v2"

  }

}
