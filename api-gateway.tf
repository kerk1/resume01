variable "myregion" {
  type    = string
  default = "eu-central-1"
}

variable "accountId" {
  type    = string
  default = "347012026804"
}

provider "aws" {
  region = "eu-central-1"
}

resource "aws_apigatewayv2_api" "lambda" {
  name          = "serverless_lambda_gw"
  protocol_type = "HTTP"
}

resource "aws_apigatewayv2_stage" "lambda" {
  api_id      = aws_apigatewayv2_api.lambda.id
  name        = "serverless_lambda_stage"
  auto_deploy = true
}
#============================================================

resource "aws_apigatewayv2_integration" "get-counter" {
  api_id = aws_apigatewayv2_api.lambda.id

  integration_uri        = aws_lambda_function.get-counter.invoke_arn
  integration_type       = "AWS_PROXY"
  integration_method     = "POST"
  payload_format_version = "2.0"
}


resource "aws_apigatewayv2_route" "get-counter" {
  api_id = aws_apigatewayv2_api.lambda.id

  route_key = "GET /get-counter"
  target    = "integrations/${aws_apigatewayv2_integration.get-counter.id}"
}


#========================================
output "api_gateway_address" {
  value = aws_apigatewayv2_stage.lambda.invoke_url
}
