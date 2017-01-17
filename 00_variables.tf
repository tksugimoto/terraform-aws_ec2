# AWS APIキー変数設定
variable "aws_access_key" {}
variable "aws_secret_key" {}

# キーペア変数設定
variable "keyname" {}

# キーペア.pemの格納ディレクトリのPath
variable "ssh_secret_key_path" {}

# 名前のPrefix
variable "prefix" {
  default     = "Test"
}

# インスタンスタイプ
# デフォルト：無料枠対象のt2.micro
variable "instance_type" {
  default     = "t2.micro"
}

# リージョン
# デフォルト：北米東部（バージニア）
variable "region" {
  default     = "us-east-1"
}

# Amazon マシンイメージ（AMI）
# デフォルト：Amazon Linux
variable "ami" {
  default = "ami-60b6c60a"
}

# デフォルトユーザー
# デフォルト：Amazon Linux
variable "ssh_user_name" {
  default = "ec2-user"
}

# ssh用port番号
variable "ssh_port" {
  default = 22
}