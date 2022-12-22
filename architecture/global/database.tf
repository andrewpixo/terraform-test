resource "aws_security_group" "db_security_group" {
  ingress {
    from_port = 5432
    to_port = 5432
    protocol = "tcp"
    cidr_blocks = [
      "0.0.0.0/0"
    ]

  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }
}


resource "aws_db_instance" "db_instance" {
  allocated_storage = 20
  storage_type = "standard"
  engine = "postgres"
  engine_version = "13.7"
  instance_class = "db.t3.micro"
  name = var.db_name
  username = var.db_user
  password = var.db_pass
  skip_final_snapshot = true
}

