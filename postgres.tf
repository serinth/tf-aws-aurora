resource "aws_rds_cluster" "default" {
  cluster_identifier        = "aurora-cluster-opensc"
  engine                    = "aurora-postgresql"
  engine_version            = "9.6.8"
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
  subnet_ids  = [ "${aws_subnet.private_app_1.id}", "${aws_subnet.private_app_2.id}" ]
  tags = {
      Namespace = "${var.namespace}"
  }
}

