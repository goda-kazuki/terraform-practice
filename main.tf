terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "ap-northeast-1"
}

#リソースタイプ+リソース名
resource "aws_instance" "app_server" {
  ami           = "ami-0b069de314c9ab4c4"
  instance_type = "t2.micro"

  tags = {
    Name = var.instance_name
  }
}

