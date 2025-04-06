provider "aws" {
  region = "ap-south-1"
}
resource "aws_s3_bucket" "state-backend-bucket" {
  bucket = "state-backend-safe-bucket-01"
}
resource "aws_dynamodb_table" "s3-backend-table" {
  name = "s3-backend-table"
  hash_key = "LockID"
  billing_mode = "PAY_PER_REQUEST"
  attribute {
    name = "LockID"
    type = "S"
  }
}