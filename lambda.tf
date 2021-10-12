

resource "aws_lambda_permission" "api_gw" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.get-counter.function_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_apigatewayv2_api.lambda.execution_arn}/*/*/*"
}



resource "aws_lambda_function" "get-counter" {
  filename      = "get-counter.zip"
  function_name = "get-counter"
  role          = aws_iam_role.lambda_exec.arn
  handler       = "get-counter.lambda_handler"
  runtime       = "python3.8"

  source_code_hash = filebase64sha256("get-counter.zip")
}


#---------------------------------------------------
resource "aws_iam_role" "lambda_exec" { #and this
  name               = "serverless_lambda2"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": [
          "lambda.amazonaws.com"
        ]
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "dynamodb-policy" {
  role       = aws_iam_role.lambda_exec.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonDynamoDBFullAccess"
}
