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
    "APP"  = "vue2048"

  }

  provisioner "remote-exec" {
      inline = [
        "sudo amazon-linux-extras install -y docker",
        "sudo service docker start",
        "sudo systemctl enable docker",
        "sudo usermod -a -G docker ec2-user",
        "sudo pip3 install docker-compose",
        "sudo docker pull ghcr.io/vlruben/hello-2048/hello-2048:latest",
        "sudo docker-compose up -d"
      ]
    }

  provisioner "local-exec" {
        command = "ansible-playbook -i aws_ec2.yml hello-2048.yml"
    }

  
}