resource "aws_rds_cluster" "default" {
  cluster_identifier        = "aurora-cluster-opensc"
  engine                    = "aurora-postgresql"
  database_name             = "opensc_db"
  master_username           = "${var.postgres_user}"
  master_password           = "${var.postgres_password}"
  backup_retention_period   = 5
  #vpc_security_group_ids    = ["${aws_security_group.aurora-sg.id}"]
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

# resource "aws_security_group" "aurora-sg" {
#   name   = "aurora-security-group"
#   vpc_id = "${aws_vpc.default.id}"

#   ingress {
#     protocol    = "tcp"
#     from_port   = 5432
#     to_port     = 5432
#     cidr_blocks = []
#   }

#   egress {
#     protocol    = -1
#     from_port   = 0 
#     to_port     = 0 
#     cidr_blocks = ["0.0.0.0/0"]
#   }
# }

output "cluster_address" {
    value = "${aws_rds_cluster.default.endpoint}"
}