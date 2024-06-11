data "aws_iam_policy_document" "static_website" {
  statement {
    sid = "${var.app_name}_bucket_policy_site"
    actions = ["s3:GetObject"]
    effect = "Allow"
    resources = ["arn:aws:s3:::${local.bucket_name}/*"]
    principals {
      type = "AWS"
      identifiers = ["*"] # TODO: This will eventually be CF [aws_cloudfront_origin_access_identity]
    }
  }
}

resource "aws_s3_bucket_policy" "static_website" {
  bucket = aws_s3_bucket.static_website.id

  policy = data.aws_iam_policy_document.static_website.json
}


resource "aws_s3_bucket" "static_website" {
  bucket = local.bucket_name
  tags = {
    Name        = var.app_name
    Environment = terraform.workspace
    Version     = var.app_version
  }
  force_destroy = true
}

resource "aws_s3_bucket_ownership_controls" "static_website" {
  bucket = aws_s3_bucket.static_website.id

  rule {
    object_ownership = "ObjectWriter"
  }
}

resource "aws_s3_bucket_acl" "static_website" {
  depends_on = [aws_s3_bucket_ownership_controls.static_website]

  bucket = aws_s3_bucket.static_website.id
  acl    = "private"
}

resource "aws_s3_bucket_website_configuration" "static_website" {
  bucket = aws_s3_bucket.static_website.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "index.html"
  }
}


##############################################################################################################################
# *NOTE: if you go to AWS click on your S3 bucket name -> `Properties` scroll down to `Static website hosting` to get the URL
# you hsould really turn this off
##############################################################################################################################
resource "aws_s3_bucket_public_access_block" "static_website" {
  bucket = aws_s3_bucket.static_website.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}