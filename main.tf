

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 1.1.9"
}

provider "aws" {
  profile = "default"
  region  = "us-east-1"

  assume_role {
    role_arn = "arn:aws:iam::695663959248:role/S3Admin"
  }

}


variable "bucket_name" {
	type = string
	nullable = false
}


resource "aws_s3_bucket" "raf" {
  bucket = var.bucket_name

  tags = {

    Name        = "Raf"

    Environment = "Dev"

  }
}

resource "aws_s3_bucket_website_configuration" "raf" {
  bucket = aws_s3_bucket.raf.bucket

  index_document {
    suffix = "index.html"
  }
}

resource "aws_s3_bucket_policy" "raf" {
  bucket = aws_s3_bucket.raf.bucket
  policy = templatefile("policy.json", { bucket = var.bucket_name })
}


resource "aws_s3_bucket_acl" "raf" {
  bucket = aws_s3_bucket.raf.bucket
  acl    = "public-read-write"
}

resource "aws_s3_bucket_cors_configuration" "raf" {

  bucket = aws_s3_bucket.raf.bucket
  
  cors_rule {
    allowed_headers = [ "*" ]
    allowed_methods = [ "HEAD", "GET", "PUT", "POST", "DELETE" ]
    allowed_origins = [ "*" ]
    expose_headers  = [ "ETag", "x-amz-meta-custom-header", "Access-Control-Allow-Origin" ]
    max_age_seconds = 3000
  }
}


/*
resource "aws_s3_object_copy" "copy" {


  for_each = fileset("dist/", "*")
    bucket = aws_s3_bucket.raf.bucket
    key = each.value
    source = "dist/${each.value}"

  

}
*/