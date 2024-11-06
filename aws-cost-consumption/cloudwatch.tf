resource "aws_cloudwatch_event_rule" "LambdaTrigger" {
  name        = "${var.prefix}-QuarterlyLambdaTrigger"
  description = "Cloudwatch Cron Trigger for Lambda Function"
  schedule_expression = var.schedule

  event_pattern = <<EOF
{
  "detail-type": [
    "AWS Console Lambda Scheduled Run"
  ]
}
EOF
}

resource "aws_cloudwatch_event_target" "CWET" {
  rule      = aws_cloudwatch_event_rule.LambdaTrigger.name
  arn       = aws_lambda_function.aws_lambda.arn
}
