# provider "aws" {
#     access_key = "access key"
#     secret_key = "secret key"
#     region = "us-east-1"
  
# }

resource "aws_lambda_function" "hk_lambda1" {
  filename      = "/home/girish/Downloads/hello.zip"
  function_name = "hk_lambda"
  role          = aws_iam_role.hklambda.arn
  handler       = "lambda_handler"
  runtime       = "python3.8"
  timeout       = 30

  tags = {
      "Name" = "hkec2-1"  
      "created by" = "Girish"
      "approved by" = "Shujat"
      "poc end date" = "20-02-2023"
      "application name" = "lambda"
      "service type" = "lambda"
    }
}

resource "aws_iam_role" "hklambda" {
  name = "example_lambda_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

output "lambda_output1" {
  value = "hello"
}

resource "aws_lambda_function" "hk_lambda2" {
  filename      = "/home/girish/Downloads/hello.zip"
  function_name = "hk_lambda2"
  role          = aws_iam_role.hklambda.arn
  handler       = "lambda_handler"
  runtime       = "python3.8"
  timeout       = 30

  tags = {
      "Name" = "hkec2-1"  
      "created by" = "Girish"
      "approved by" = "Shujat"
      "poc end date" = "20-02-2023"
      "application name" = "lambda"
      "service type" = "lambda"
    }
}

output "lambda_output2" {
  value = "hello"
}
