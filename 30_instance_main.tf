
data "template_file" "user_data_app" {
  template = "${file("templates/user_data.tpl")}"

  vars {
    ssh_port = "${var.ssh_port}"
  }
}

resource "aws_instance" "main" {
  subnet_id = "${aws_subnet.public.id}"
  associate_public_ip_address = true
  disable_api_termination = true
  instance_type = "${var.instance_type}"
  ami = "${var.ami}"
  key_name = "${aws_key_pair.deployer.key_name}"
  # 初回インスタンス生成時に実行される処理(sshの待ち受けポート変更) 
  user_data = "${data.template_file.user_data_app.rendered}"
  vpc_security_group_ids = [
    "${aws_security_group.allow_ssh.id}",
    "${aws_security_group.allow_all_outbound.id}",
    "${aws_security_group.allow_http_inbound.id}"
  ]
  iam_instance_profile = "${aws_iam_instance_profile.profile.name}"
  tags {
    Name = "${var.prefix}-main"
  }
}
