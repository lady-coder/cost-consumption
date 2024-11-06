####SQS 
output "base_queue_url" {
  value = aws_sqs_queue.base_queue.arn
}


output "deadletter_queue_url" {
  value = aws_sqs_queue.deadletter_queue.id
}

output "lambda_name" {
  value = aws_lambda_function.aws_lambda.id
}

output "lambda_arn" {
  value = aws_lambda_function.aws_lambda.arn
}

output "lambda_iam" {
  value = aws_iam_role.lambda_role.arn
}

output "cloudwatch_alarm" {
  value = aws_cloudwatch_event_rule.LambdaTrigger
}
