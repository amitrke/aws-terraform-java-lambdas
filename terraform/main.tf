provider "aws" {
  region = "us-east-1"
}

resource "aws_iam_role" "lambda_execution_role" {
  name = "MyLambdaHandlerRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_execution_role_policy_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
  role       = aws_iam_role.lambda_execution_role.name
}

data "archive_file" "lambda_deployment_package" {
  type        = "zip"
  source_dir = "../lambda-functions/target/"
  output_path = "code.zip"
}

resource "aws_lambda_function" "calc_lambda_handler" {
  filename      = data.archive_file.lambda_deployment_package.output_path
  function_name = "CalcHandler"
  role          = aws_iam_role.lambda_execution_role.arn
  handler       = "com.example.CalcHandler::handleRequest"
  runtime       = "java11"
}