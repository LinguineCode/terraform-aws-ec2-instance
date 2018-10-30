output "instance_iam_role" {
  value = "${aws_iam_role.main.name}"
}

output "instance_id" {
  value = "${aws_instance.main.id}"
}

output "instance_private_ip" {
  value = "${aws_instance.main.private_ip}"
}
