# terraform-aws-ec2-instance

A terraform module that creates an EC2 instance according to best practices. At this time, the meaning of _best practices_ is limited to enabling SSM support.

## Outputs

Supported module outputs are:
  1. `instance_iam_role` (string)
  1. `instance_id` (string)
  1. `instance_private_ip` (string)

## Usage

```
data "aws_ami" "bitnami-mongodb" {
  most_recent = true

  filter {
    name   = "name"
    values = ["bitnami-mongodb-4.0.2-0-linux-ubuntu-16.04-x86_64-hvm-ebs-mp-*"]
  }

  owners = ["679593333241"] # Bitnami
}

module "mongodb" {
  source  = "github.com/seanscottking/terraform-aws-ec2-instance.git"

  ami                    = "${data.aws_ami.bitnami-mongodb.id}"
  type                   = "t2.micro"
  subnet_id              = "${element(module.vpc.private_subnet_ids["private"],0)}"
  userdata               = "${data.template_file.mongodb-firstboot.rendered}"
  vpc_security_group_ids = ["${module.vpc.default_security_group_id}"]

  tags = {
    Name = "${local.name_tag}-mongodb"
  }
}
```