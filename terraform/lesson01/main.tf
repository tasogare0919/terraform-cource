terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = "ap-northeast-1"
}

resource "aws_instance" "tf_test_server" {
  ami           = "ami-09ebacdc178ae23b7"
  instance_type = "t3.micro"

  tags = {
    Name = "tf-test"
  }
}