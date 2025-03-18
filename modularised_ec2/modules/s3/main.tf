provider "aws" {
  region = "ap-south-1"
}

resource "aws_s3_bucket" "s3-state-backend-0" {
  bucket = "s3-state-backend-0"
}