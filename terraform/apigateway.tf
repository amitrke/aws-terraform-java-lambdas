resource "aws_api_gateway_rest_api" "my_api" {
  name = "MyAPI"
}

module "calc" {
  source = "./modules/httpmethod"
  apigw_id = aws_api_gateway_rest_api.my_api.id
  apigw_resource_id = aws_api_gateway_rest_api.my_api.root_resource_id
  path = "calc"
  http_method = "POST"
  lambda_arn = aws_lambda_function.calc_lambda_handler.invoke_arn
}

module "greet" {
  source = "./modules/httpmethod"
  apigw_id = aws_api_gateway_rest_api.my_api.id
  apigw_resource_id = aws_api_gateway_rest_api.my_api.root_resource_id
  path = "greet"
  http_method = "POST"
  lambda_arn = aws_lambda_function.greet_lambda_handler.invoke_arn
}

resource "aws_api_gateway_deployment" "my_api_deployment" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  stage_name  = "prod"
  depends_on = [
    module.calc,
    module.greet
  ]
}

resource "aws_lambda_permission" "my_lambda_permission" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.calc_lambda_handler.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_deployment.my_api_deployment.execution_arn}/*/*"
}