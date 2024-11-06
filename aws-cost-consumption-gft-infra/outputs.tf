output "lambda_arn" {
  value = aws_lambda_function.aws_lambda.arn
}

output "lambda_iam_role" {
  value = aws_lambda_function.aws_lambda.role
}

output "rds_arn" {
  value = aws_db_instance.rds-db.arn
}

output "pass" {
  value = data.aws_secretsmanager_secret.secrets
}

output "rds_endpoint" {
  value = aws_db_instance.rds-db.endpoint
}

output "rds_name" {
  value = aws_db_instance.rds-db.name
}

output "rds_username" {
  value = aws_db_instance.rds-db.username
  sensitive=true
}

output "rds_port" {
  value = aws_db_instance.rds-db.port
}
output "vpc" {
  value = aws_vpc.vpc.id
}

output "public_subnets" {
  value = [for s in aws_subnet.public_subnet : s.id]
}

output "private_subnets" {
  value = [for s in aws_subnet.private_subnet : s.id]
}

output "rds_sg" {
  value = aws_security_group.mydb1.arn
}