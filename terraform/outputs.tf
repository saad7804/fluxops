
output "artifact_bucket_name" {
  description = "S3 bucket for FluxOps build artifacts"
  value       = aws_s3_bucket.fluxops_artifacts.bucket
}

output "artifact_bucket_arn" {
  description = "ARN of the FluxOps artifact bucket"
  value       = aws_s3_bucket.fluxops_artifacts.arn
}
