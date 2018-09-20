resource "aws_rds_cluster" "default" {
  cluster_identifier        = "aurora-cluster-opensc"
  engine                    = "aurora-postgresql"
  engine_version            = "10.4"
  database_name             = "opensc_db"
  master_username           = "${var.postgres_user}"
  master_password           = "${var.postgres_password}"
  backup_retention_period   = 5
  db_subnet_group_name      = "${aws_db_subnet_group.aurora.name}"
}
resource "aws_rds_cluster_instance" "cluster_instances" {
  count              = 2
  identifier         = "aurora-cluster-opensc-${count.index}"
  cluster_identifier = "${aws_rds_cluster.default.id}"
  instance_class     = "db.r4.large"
  engine             = "aurora-postgresql"
}

resource "aws_db_subnet_group" "aurora" {
  name        = "db-private-subnet"
  description = "Private subnets for RDS instance"
  subnet_ids  = [ "${aws_subnet.private.*.id}" ]
  tags = {
      Namespace = "${var.namespace}"
  }
}

output "cluster_address" {
    value = "${aws_rds_cluster.default.endpoint}"
}