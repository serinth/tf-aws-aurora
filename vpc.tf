resource "aws_vpc" "default" {
    cidr_block = "${var.vpc_cidr}"
    enable_dns_hostnames = true
    tags {
        Name = "${var.namespace}-terraform-aws-vpc"
        Namespace = "${var.namespace}"
    }
}

resource "aws_subnet" "private" {
  vpc_id            = "${aws_vpc.default.id}"
  count             = "${length(split(",", var.aws_availability_zones))}"
  availability_zone = "${element(split(",", var.aws_availability_zones), count.index)}"
  cidr_block        = "10.0.${count.index}.0/24"
}

output "VPC ARN" {
    value = "${aws_vpc.default.arn}"
}

