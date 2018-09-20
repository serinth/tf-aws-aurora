output "subnet_public_1" {
  value = "${aws_subnet.public_nat_1.id}"
}
output "subnet_public_2" {
  value = "${aws_subnet.public_nat_2.id}"
}
output "subnet_private_1" {
  value = "${aws_subnet.private_app_1.id}"
}
output "subnet_private_2" {
  value = "${var.multi_az ? join("",aws_subnet.private_app_2.*.id) : ""}"
}
output "nat_gw_ip_1" {
  value = "${local.nat_gw ? join("", aws_eip.nat_1.*.public_ip) : ""}"
}
output "nat_gw_ip_2" {
  value = "${local.nat_gw_multi_az ? join("", aws_eip.nat_2.*.public_ip) : ""}"
}
output "vpc_id" {
  value = "${aws_vpc.default.id}"
}
output "default_security_group" {
  value = "${aws_vpc.default.default_security_group_id}"
}
output "cluster_address" {
    value = "${aws_rds_cluster.default.endpoint}"
}