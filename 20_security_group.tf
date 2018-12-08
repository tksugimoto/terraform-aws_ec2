# ssh
resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh_in_vpc"
  description = "Allow ssh in vpc"
  vpc_id      = "${aws_vpc.main.id}"

  ingress {
    from_port   = "${var.ssh_port}"
    to_port     = "${var.ssh_port}"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port        = "${var.ssh_port}"
    to_port          = "${var.ssh_port}"
    protocol         = "tcp"
    ipv6_cidr_blocks = ["::/0"]
  }

  tags {
    Name = "${var.prefix}-ssh(${var.ssh_port})を許可"
  }
}

# 外への全アクセス許可
resource "aws_security_group" "allow_all_outbound" {
  name        = "allow_all_outbound"
  description = "Allow all outbound traffic"
  vpc_id      = "${aws_vpc.main.id}"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    ipv6_cidr_blocks = ["::/0"]
  }

  tags {
    Name = "${var.prefix}-外へのアクセスを許可"
  }
}

# 外からのHTTPアクセス（9000）を許可
resource "aws_security_group" "allow_http_inbound" {
  name   = "Allow http inbound"
  vpc_id = "${aws_vpc.main.id}"

  ingress {
    from_port   = 9000
    to_port     = 9000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port        = 9000
    to_port          = 9000
    protocol         = "tcp"
    ipv6_cidr_blocks = ["::/0"]
  }

  tags {
    Name = "${var.prefix}-allow_http_inbound"
  }
}
