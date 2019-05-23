output "SSH Config" {
  value = <<EOF


[~/.ssh/config]
=======================================================

Host ${aws_instance.main.public_ip} ${join(" ", aws_instance.main.ipv6_addresses)}
	Port			${var.ssh_port}
	User			${var.ssh_user_name}
	IdentityFile		${var.ssh_secret_key_path}
	FingerprintHash		sha256

=======================================================
EOF
}

data "aws_instance" "generated" {
  instance_id = "${aws_instance.main.id}"

  depends_on = ["aws_instance.main"]
}

output "tags" {
  value = "${data.aws_instance.generated.tags}"
}
