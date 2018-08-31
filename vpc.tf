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

resource "aws_security_group" "web" {
    name = "vpc_web"
    description = "Allow incoming HTTP connections."

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = -1
        to_port = -1
        protocol = "icmp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

    vpc_id = "${aws_vpc.default.id}"

    tags {
        Name = "WebServerSG"
    }
}

output "VPC ARN" {
    value = "${aws_vpc.default.arn}"
}

output "Subnet ARNS" {
    value = "${aws_subnet.private.*.arn}"
}

output "Web SG ARN" {
    value = "${aws_security_group.web.arn}"
}

