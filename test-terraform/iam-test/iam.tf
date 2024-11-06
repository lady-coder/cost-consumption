/**
 * Create function role with appropriate access policies
 */
resource "aws_iam_role" "lambda_role" {
  name = "${var.prefix}-client-lambda-role"
  permissions_boundary = "arn:aws:iam::522557265874:policy/ServiceRoleBoundary"
  assume_role_policy = <<-EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Principal": {
          "Service": [
            "lambda.amazonaws.com"
          ]
        },
        "Action": [
          "sts:AssumeRole"
        ]
      }
    ]
  }
EOF
  tags = {
    Owner = var.project_name
    Name        = "${var.prefix}-client-lambda-role"
    Environment = "${var.client_env}"
  }
}

resource "aws_iam_policy" "lambda_policy" {
  name = "${var.prefix}-client-lambda-policy"

  policy = <<-EOF
{
    "Statement": [
        {
            "Action": [
                "logs:CreateLogGroup",
                "logs:CreateLogStream",
                "logs:PutLogEvents"
            ],
            "Effect": "Allow",
            "Resource": "*"
        },
        {
            "Action" : [
                "ce:*"
                ],
                "Effect" : "Allow",
                "Resource": "*"
        },
        {
            "Action" : [
                "sqs:SendMessage",
                "sqs:DeleteMessage",
                "sqs:ChangeMessageVisibility",
                "sqs:ReceiveMessage",
                "sqs:TagQueue",
                "sqs:UntagQueue",
                "sqs:PurgeQueue",
                "sqs:GetQueueUrl"
                ],
                "Effect" : "Allow",
                "Resource" : "*"
        }
    ],
    
    "Version": "2012-10-17"
}
EOF
}

resource "aws_iam_role_policy_attachment" "lambda_execution_policy" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_role_policy_attachment" "additional_policies" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = aws_iam_policy.lambda_policy.arn
}