
resource "aws_iam_instance_profile" "stop_self_profile" {
	name = "${var.prefix}-stop_self_profile"
	roles = ["${aws_iam_role.stop_self_role.name}"]
}

resource "aws_iam_role" "stop_self_role" {
	name = "${var.prefix}-stop_self_role"
	assume_role_policy = "${file("./iam-role/assume_role_policy-trust_ec2.json")}"
}

resource "aws_iam_role_policy" "stop_self_policy" {
	name = "${var.prefix}-stop_self_policy@${aws_instance.main.id}"
	role = "${aws_iam_role.stop_self_role.id}"
	policy = "${data.template_file.stop_self_policy.rendered}"
}

data "template_file" "stop_self_policy" {
	template = "${file("templates/aws_iam_role_policy-stop_self_instances.tpl")}"

	vars {
		region = "${var.region}"
		aws_instance_id = "${aws_instance.main.id}"
	}
}
