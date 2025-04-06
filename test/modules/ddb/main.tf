provider "aws" {
    region = "ap-south-1"
}
resource "aws_dynamodb_table" "s3-backend" {
    name = "s3-backend-table"
    billing_mode = "PAY_PER_REQUEST"
    hash_key = "LockID"
    attribute {
      name = "LockID"
      type = "S"
    }
}