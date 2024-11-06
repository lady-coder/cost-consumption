resource "null_resource" "install_python_dependencies" {
  
  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command = "bash ${path.module}/scripts/create_pkg.sh"

    environment = {
      source_code_path = "lambda_function"
      function_name    = "client-report-storage-master"
      path_module      = path.module
      runtime          = "python3.7"
      path_cwd         = path.cwd
    }
  }
}

resource "random_uuid" "this" {}

data "archive_file" "create_pkg" {
  depends_on  = [null_resource.install_python_dependencies]
  source_dir  = "${path.module}/lambda_function/"
  output_path = "${path.module}/client-report-generator-${random_uuid.this.result}.zip"
  type        = "zip"
}

resource "aws_lambda_function" "aws_lambda" {
  function_name = "client-report-storage-master"
  description   = "Master lambda to store reports in db"
  handler       = "lambda.lambda_handler"
  runtime       = "python3.7"

  role        = aws_iam_role.lambda_role.arn
  memory_size = 128
  timeout     = 60

  depends_on       = [null_resource.install_python_dependencies]
  source_code_hash = data.archive_file.create_pkg.output_base64sha256
  filename         = data.archive_file.create_pkg.output_path
  tags = {
    Name        = "client-report-storage-master"
  }
  environment {
    variables = {
      region      = var.region
      db_host     = aws_db_instance.rds-db.address
      db_username = aws_db_instance.rds-db.username
      db_password = jsondecode(data.aws_secretsmanager_secret_version.secretVers.secret_string)["password"]
      db_port     = aws_db_instance.rds-db.port
      db_name     = aws_db_instance.rds-db.name
    }
  }
}
