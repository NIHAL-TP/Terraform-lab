terraform {
  backend "s3" {
    bucket = "state-backend-safe-bucket-01"
    dynamodb_table = "s3-backend-table"
    key = "terraform.tfstate"
    region = "ap-south-1"
  }
}