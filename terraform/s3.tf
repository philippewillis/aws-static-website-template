data "aws_iam_policy_document" "website" {
  statement {
    sid = "bucket_policy_website"
    actions = [ "s3:GetObject" ]
    effect = "Allow"
    resources = [
      "arn:aws:s3:::${local.bucket_name}/*",
    ]
  }
}

resource "aws_iam_policy" "website" {
  name   = "static_website_policy"
  path   = "/"
  policy = data.aws_iam_policy_document.website.json
}


resource "aws_s3_bucket" "website" {
  bucket = local.bucket_name
  tags = {
    Name        = "Website Bucket"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_ownership_controls" "website" {
  bucket = aws_s3_bucket.website.id
  rule {
    object_ownership = "ObjectWriter"
  }
}

resource "aws_s3_bucket_acl" "website" {
  depends_on = [aws_s3_bucket_ownership_controls.website]
  bucket = aws_s3_bucket.website.id
  acl    = "private"
}

resource "aws_s3_bucket_website_configuration" "website" {
  bucket = aws_s3_bucket.website.id
  index_document {
    suffix = "index.html"
  }
  error_document {
    key = "index.html"
  }
}