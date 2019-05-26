resource "aws_iam_instance_profile" "profile" {
  name = "${var.prefix}-profile"
  role = "${aws_iam_role.role_for_ec2.name}"
}

resource "aws_iam_role" "role_for_ec2" {
  name               = "${var.prefix}-role_for_ec2"
  assume_role_policy = "${file("./iam-role/assume_role_policy-trust_ec2.json")}"
}

resource "aws_iam_role_policy" "create_tags" {
  name   = "${var.prefix}-create_tags@${aws_instance.main.id}"
  role   = "${aws_iam_role.role_for_ec2.id}"
  policy = "${file("iam-role/aws_iam_role_policy-create_tags.json")}"
}

resource "aws_iam_role_policy_attachment" "AmazonEC2RoleforSSM" {
  role       = "${aws_iam_role.role_for_ec2.id}"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforSSM"
}
