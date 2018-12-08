resource "aws_key_pair" "deployer" {
  key_name_prefix = "${var.prefix}-"
  public_key      = "${file("${var.ssh_public_key_path}")}"
}
