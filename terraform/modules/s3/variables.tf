variable "bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
}

variable "versioning_enabled" {
  description = "Whether to enable versioning on the bucket"
  type        = bool
  default     = true
}

variable "force_destroy" {
  description = "Whether to force destroy the bucket (delete even if non-empty)"
  type        = bool
  default     = false
}

variable "tags" {
  description = "A map of tags to assign to the bucket"
  type        = map(string)
  default     = {}
}

variable "node_group_role_name" {
  description = "IAM role name of the EKS node group"
  type        = string
}