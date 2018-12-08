output "SSH Config" {
  value = <<EOF


[~/.ssh/config]
=======================================================

Host aws
	HostName		${aws_instance.main.public_ip}
	Port			${var.ssh_port}
	User			${var.ssh_user_name}
	IdentityFile		${var.ssh_secret_key_path}
	FingerprintHash		md5

=======================================================
EOF
}
