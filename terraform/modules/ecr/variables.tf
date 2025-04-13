variable "repository_name" {}
variable "tags" { type = map(string) }

# modules/ecr/outputs.tf
output "repository_url" {
  value = aws_ecr_repository.this.repository_url
}