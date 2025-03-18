provider "aws" {
  region = "ap-south-1"
}

resource "aws_dynamodb_table" "State-backend-dynamodb-table" {
  name           = "State_backend"
  billing_mode   = "PAY_PER_REQUEST"

  hash_key       = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
}