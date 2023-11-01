terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = "us-west-1"
}

// Create ec2 instance
resource "aws_instance" "cjd-chkpt-instance" {
  ami                       = var.image_id

  instance_type             = "t2.micro"
  vpc_security_group_ids    = [aws_security_group.cjd-chkpt-sg.id]
  key_name                  = "cjd-tf-keypair"
  iam_instance_profile      = aws_iam_instance_profile.cjd-chkpt-instance.id
  user_data                 = file("myStartupScript.sh")

    tags = {
  Name = "cjd-chkpt-instance"
  }

}

// Create instance profile
resource "aws_iam_instance_profile" "cjd-chkpt-instance" {
  name = "cjd-chkpt-instance"
  role = "cjd-chkpt-role"
}

// Create a S3 bucket
resource "aws_s3_bucket" "cjd-chkpt-bucket" {
    bucket      = "cjd-chkpt-bucket"

    tags = {
      name          = "cjd-chkpt-bucket"
      Environment   = "Dev"
    }
  
}

resource "aws_s3_bucket_public_access_block" "public_access_block" {
  bucket = aws_s3_bucket.cjd-chkpt-bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

// Create a S3 object (a.k.a my jar file here)
resource "aws_s3_object" "cjd-chkpt-jarfile" {
  depends_on = [ aws_s3_bucket.cjd-chkpt-bucket ]
  bucket = "cjd-chkpt-bucket"
  key = "g-hello.jar"
  source = var.jar-file-name

}

// Create a s3 bucket policy
/*resource "aws_s3_bucket_policy" "cjd-chkpt-bucket-policy"  {
  depends_on = [ aws_s3_bucket.cjd-chkpt-bucket ]
  bucket = aws_s3_bucket.cjd-chkpt-bucket.id
  policy = file("bucketPolicy.json")
}*/