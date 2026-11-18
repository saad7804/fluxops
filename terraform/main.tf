
resource "aws_s3_bucket" "fluxops_artifacts" {
  bucket = "fluxops-artifacts-888869353635-ap-south-1"

  tags = {
    Name        = "fluxops-artifacts"
    Project     = "FluxOps"
    Environment = "DevOps"
    ManagedBy   = "Terraform"
  }
}

resource "aws_s3_bucket_versioning" "fluxops_artifacts" {
  bucket = aws_s3_bucket.fluxops_artifacts.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "fluxops_artifacts" {
  bucket = aws_s3_bucket.fluxops_artifacts.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "fluxops_artifacts" {
  bucket = aws_s3_bucket.fluxops_artifacts.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
