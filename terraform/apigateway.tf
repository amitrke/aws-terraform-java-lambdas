resource "aws_api_gateway_rest_api" "this" {
  name = "MyAPI"
}

module "calc" {
  source = "./modules/httpmethod"
  apigw_id = aws_api_gateway_rest_api.this.id
  apigw_resource_id = aws_api_gateway_rest_api.this.root_resource_id
  path = "calc"
  http_method = "POST"
  lambda_arn = aws_lambda_function.calc_lambda_handler.invoke_arn
}

module "greet" {
  source = "./modules/httpmethod"
  apigw_id = aws_api_gateway_rest_api.this.id
  apigw_resource_id = aws_api_gateway_rest_api.this.root_resource_id
  path = "greet"
  http_method = "POST"
  lambda_arn = aws_lambda_function.greet_lambda_handler.invoke_arn
}

resource "aws_api_gateway_deployment" "this" {
  rest_api_id = aws_api_gateway_rest_api.this.id

  triggers = {
    redeployment = sha1(jsonencode({
      calc = module.calc,
      greet = module.greet
    }))
  }

  depends_on = [
    module.calc,
    module.greet
  ]
}

resource "aws_lambda_permission" "calc_lambda_invoke" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.calc_lambda_handler.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${replace(aws_api_gateway_deployment.this.execution_arn, var.stage_name, "")}*/*"
}

resource "aws_lambda_permission" "greet_lambda_invoke" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.greet_lambda_handler.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${replace(aws_api_gateway_deployment.this.execution_arn, var.stage_name, "")}*/*"
}

resource "aws_api_gateway_stage" "this" {
  stage_name    = var.stage_name
  rest_api_id   = aws_api_gateway_rest_api.this.id
  deployment_id = aws_api_gateway_deployment.this.id
}