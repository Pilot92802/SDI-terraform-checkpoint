// Add a role
resource "aws_iam_role" "cjd-chkpt-role" {
  name  = "cjd-chkpt-role"
  assume_role_policy = jsonencode({
    Version     = "2012-10-17"
    Statement   = [
        {
            Action  = "sts:AssumeRole"
            Effect  = "Allow"
            Sid     = ""
            Principal = {
                Service = "ec2.amazonaws.com"
            }
        }
    ]
  })
}

// Add a role policy

resource "aws_iam_role_policy" "cjd-chkpt-role-policy" {
    name = "cjd-chkpt-role-policy"
    role = aws_iam_role.cjd-chkpt-role.id

    policy =  jsonencode({
        Version     = "2012-10-17"
        Statement   = [
            {
                Action = [
                    "s3:CreateBucket",
                    "s3:DeleteBucket",
                    "s3:ListAllMyBuckets",
                    "s3:GetObject",
                    "s3:PutObject"
                ]
                Effect  = "Allow",
                Resource = "arn:aws:s3:::cjd-chkpt-bucket/*"
            }
        ]
    })
  
}