provider "aws" {
  region = "ap-south-1"
}

resource "aws_s3_bucket" "aws-s3-bucket-001" {
  bucket = "aws-s3-bucket-001"
}