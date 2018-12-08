# VPC設定
resource "aws_vpc" "main" {
  cidr_block                       = "10.0.0.0/16"
  assign_generated_ipv6_cidr_block = true
  enable_dns_hostnames             = true

  tags {
    Name = "${var.prefix}-VPC"
  }
}

# ゲートウェイ
resource "aws_internet_gateway" "igw" {
  vpc_id = "${aws_vpc.main.id}"

  tags {
    Name = "${var.prefix}-Gateway"
  }
}

# サブネット1: public ssh/frontend用
resource "aws_subnet" "public" {
  vpc_id     = "${aws_vpc.main.id}"
  cidr_block = "10.0.1.0/24"

  tags {
    Name = "${var.prefix}-Public"
  }
}

# ルーティングテーブルを新規作成
resource "aws_route_table" "route_to_igw" {
  vpc_id = "${aws_vpc.main.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.igw.id}"
  }

  tags {
    Name = "${var.prefix}-外部接続用"
  }
}

# 外部へ繋がるルーティングテーブルをネットワークに設定
resource "aws_route_table_association" "a" {
  subnet_id      = "${aws_subnet.public.id}"
  route_table_id = "${aws_route_table.route_to_igw.id}"
}
