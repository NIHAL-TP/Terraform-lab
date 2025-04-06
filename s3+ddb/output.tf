output "ddb-name" {
  value = aws_dynamodb_table.s3-backend-table.name
}

output "s3-name" {
  value = aws_s3_bucket.state-backend-bucket.bucket
}