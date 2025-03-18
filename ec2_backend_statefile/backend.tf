terraform {
  backend "s3" {
    bucket = "s3-state-backend-0"
    region = "ap-south-1"
    key = "nihal/terraform.tfstate"
    dynamodb_table = "State_backend"
  }
}