resource "aws_vpc" "handson_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  tags                 = {
    Name = "terraform-handson-vpc"
  }
}

resource "aws_subnet" "handson_public_1a_sn" {
  vpc_id            = aws_vpc.handson_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = var.az_a

  tags = {
    Name = "terraform-handson-public-1a-sn"
  }
}

resource "aws_internet_gateway" "handson_igw" {
  vpc_id = aws_vpc.handson_vpc.id
  tags   = {
    Name = "terraform-handson-igw"
  }
}

resource "aws_route_table" "handson-public-rt" {
  vpc_id = aws_vpc.handson_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.handson_igw.id
  }
  tags = {
    Name = "terraform-handson-public-rt"
  }
}

# SubnetとRoute tableの関連付け
resource "aws_route_table_association" "handson_public_rt_association" {
  route_table_id = aws_route_table.handson-public-rt.id
  subnet_id      = aws_subnet.handson_public_1a_sn.id
}

# ---------------------------
# Security Group
# ---------------------------
# 自分のパブリックIP取得
data "http" "ifconfig" {
  url = "http://ipv4.icanhazip.com/"
}

variable "allowed_cidr" {
  default = null
}

locals {
  myip         = chomp(data.http.ifconfig.response_body)
  allowed_cidr = (var.allowed_cidr==null)?"${local.myip}/32" : var.allowed_cidr
}

# Security Group作成
resource "aws_security_group" "handson_ec2_sg" {
  name        = "terraform-handson-ec2-sg"
  description = "For EC2 Linux"
  vpc_id      = aws_vpc.handson_vpc.id
  tags        = {
    Name = "terraform-handson-ec2-sg"
  }

  ingress {
    from_port   = 22
    protocol    = "tcp"
    to_port     = 22
    cidr_blocks = [local.allowed_cidr]
  }
  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}
