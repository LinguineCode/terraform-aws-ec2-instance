resource "aws_instance" "main" {
  ami                     = "${var.ami}"
  disable_api_termination = "${var.disable_api_termination}"
  key_name                = "${var.key_name}"
  iam_instance_profile    = "${aws_iam_instance_profile.main.id}"
  instance_type           = "${var.type}"
  monitoring              = true
  subnet_id               = "${var.subnet_id}"
  user_data               = "${var.userdata}"
  vpc_security_group_ids  = ["${var.vpc_security_group_ids}"]

  tags = "${var.tags}"
}

resource "aws_iam_instance_profile" "main" {
  role = "${aws_iam_role.main.name}"
}

resource "aws_iam_role" "main" {
  path = "/"

  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "sts:AssumeRole",
            "Principal": {
               "Service": "ec2.amazonaws.com"
            },
            "Effect": "Allow",
            "Sid": ""
        }
    ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "AmazonEC2RoleforSSM" {
  role       = "${aws_iam_role.main.name}"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforSSM"
}
