# S3の作成
resource "aws_s3_bucket" "terraform_s3" {
  bucket = "terraform-s3-20230722sut"
  tags = {
    Name        = "terraform-s3"
  }
}

# パブリックアクセスの許可
resource "aws_s3_bucket_public_access_block" "terraform_s3_public_access_block" {
    bucket = aws_s3_bucket.terraform_s3.id
    block_public_acls       = false
    block_public_policy     = false
    ignore_public_acls      = false
    restrict_public_buckets = false
}
