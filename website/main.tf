provider "aws" {
  region = "eu-central-1"
}

resource "aws_s3_bucket_object" "website" {
  for_each     = fileset("website/", "*")
  bucket       = aws_s3_bucket.my-s3-website.id
  key          = each.value
  source       = "website/${each.value}"
  etag         = filemd5("website/${each.value}")
  acl          = "public-read-write"
  content_type = "text/html"
}


resource "aws_s3_bucket" "my-s3-website" {
  bucket = "lwolynski"
  acl    = "public-read-write"
  policy = file("policy.json")

  website {
    index_document = "index.html"
    error_document = "error.html"

  }
}
