data "aws_secretsmanager_secret" "secrets" {
  name = "prod/rds/password"
}

data "aws_secretsmanager_secret_version" "secretVers" {
  secret_id = data.aws_secretsmanager_secret.secrets.id
}

resource "aws_db_instance" "rds-db" {
  allocated_storage       = 256 # gigabytes
  backup_retention_period = 7   # in days
  db_subnet_group_name    = "main-rds-group"
  engine                  = "postgres"
  engine_version          = "10"
  identifier              = "gftclientdb"
  instance_class          = "db.t3.medium"
  multi_az                = false
  name                    = "gftclientdb"
  #parameter_group_name     = "mydbparamgroup1" # if you have tuned it
  password               = jsondecode(data.aws_secretsmanager_secret_version.secretVers.secret_string)["password"]
  port                   = 5432
  publicly_accessible    = true
  storage_encrypted      = true # you should always do this
  storage_type           = "gp2"
  username               = var.db_username
  vpc_security_group_ids = ["${aws_security_group.mydb1.id}"]
}

resource "aws_security_group" "mydb1" {
  name = "mydb1"

  description = "RDS postgres servers"
  vpc_id      = aws_vpc.vpc.id ###lookup from main.tf vpc 

  # Only postgres in
  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow all outbound traffic.
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "aws_db_subnet_group" "rds" {
  name       = "main-rds-group"
  subnet_ids = [for s in aws_subnet.public_subnet : s.id]

  tags = {
    Name = "main-rds-group"
  }
}