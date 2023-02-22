resource "aws_api_gateway_rest_api" "my_api" {
  name = "MyAPI"
}

resource "aws_api_gateway_resource" "my_resource" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  parent_id   = aws_api_gateway_rest_api.my_api.root_resource_id
  path_part   = "calc"
}

resource "aws_api_gateway_method" "my_method" {
  rest_api_id   = aws_api_gateway_rest_api.my_api.id
  resource_id   = aws_api_gateway_resource.my_resource.id
  http_method   = "POST"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "my_integration" {
  rest_api_id          = aws_api_gateway_rest_api.my_api.id
  resource_id          = aws_api_gateway_resource.my_resource.id
  http_method          = aws_api_gateway_method.my_method.http_method
  integration_http_method = "POST"
  type                 = "AWS_PROXY"
  uri                  = aws_lambda_function.calc_lambda_handler.invoke_arn
}

resource "aws_api_gateway_method_response" "my_method_response" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  resource_id = aws_api_gateway_resource.my_resource.id
  http_method = aws_api_gateway_method.my_method.http_method
  status_code = "200"
}

resource "aws_api_gateway_deployment" "my_api_deployment" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  stage_name  = "prod"
  depends_on = [aws_api_gateway_method_response.my_method_response]
}

resource "aws_lambda_permission" "my_lambda_permission" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.calc_lambda_handler.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_deployment.my_api_deployment.execution_arn}/*/*"
}