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

resource "aws_lambda_function" "calc_lambda_handler" {
  filename      = "../lambda-functions/target/lambda-functions-1.0-SNAPSHOT.jar"
  function_name = "CalcHandler"
  role          = aws_iam_role.lambda_execution_role.arn
  handler       = "com.example.CalcHandler::handleRequest"
  runtime       = "java21"
}

resource "aws_lambda_function" "greet_lambda_handler" {
  filename      = "../lambda-functions/target/lambda-functions-1.0-SNAPSHOT.jar"
  function_name = "GreetHandler"
  role          = aws_iam_role.lambda_execution_role.arn
  handler       = "com.example.GreetHandler::handleRequest"
  runtime       = "java21"
}