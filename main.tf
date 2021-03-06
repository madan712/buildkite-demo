

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.15.1"
    }
  }

  required_version = ">= 1.1.9"
}

provider "aws" {

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

resource "aws_s3_bucket_ownership_controls" "example" {
  bucket = aws_s3_bucket.raf.bucket 

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_policy" "raf" {
  bucket = aws_s3_bucket.raf.bucket
  policy = templatefile("policy.json", { bucket = var.bucket_name })
}


module "templatefile" {
  source = "hashicorp/dir/template"
  base_dir = "dist"
}


resource "aws_s3_object" "copy" {

  for_each = module.templatefile.files
    bucket = aws_s3_bucket.raf.bucket
    key = each.key
    source = each.value.source_path
	content_type = each.value.content_type
	source_hash = each.value.digests.base64sha512
	
}