resource "aws_s3_bucket" "this" {
  bucket         = var.bucket_name
  force_destroy  = true
}

resource "aws_iam_policy" "node_group_s3_access" {
  name        = "${var.bucket_name}-access-policy"
  description = "Grants EKS node group access to this S3 bucket"
  policy      = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = ["s3:ListBucket"]
        Resource = "arn:aws:s3:::${aws_s3_bucket.this.id}"
      },
      {
        Effect = "Allow"
        Action = [
          "s3:GetObject",
          "s3:PutObject"
        ]
        Resource = "arn:aws:s3:::${aws_s3_bucket.this.id}/*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "node_group_attach" {
  role       = var.node_group_role_name
  policy_arn = aws_iam_policy.node_group_s3_access.arn
}
