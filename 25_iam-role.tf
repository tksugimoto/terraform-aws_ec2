
resource "aws_iam_instance_profile" "profile" {
	name = "${var.prefix}-profile"
	roles = ["${aws_iam_role.role_for_ec2.name}"]
}

resource "aws_iam_role" "role_for_ec2" {
	name = "${var.prefix}-role_for_ec2"
	assume_role_policy = "${file("./iam-role/assume_role_policy-trust_ec2.json")}"
}

resource "aws_iam_role_policy" "stop_self_policy" {
	name = "${var.prefix}-stop_self_policy@${aws_instance.main.id}"
	role = "${aws_iam_role.role_for_ec2.id}"
	policy = "${data.template_file.stop_self_policy.rendered}"
}

data "template_file" "stop_self_policy" {
	template = "${file("templates/aws_iam_role_policy-stop_self_instances.tpl")}"

	vars {
		region = "${var.region}"
		aws_instance_id = "${aws_instance.main.id}"
	}
}


resource "aws_iam_role_policy" "create_tags" {
	name = "${var.prefix}-create_tags@${aws_instance.main.id}"
	role = "${aws_iam_role.role_for_ec2.id}"
	policy = "${file("iam-role/aws_iam_role_policy-create_tags.json")}"
}
