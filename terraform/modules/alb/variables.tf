variable "name" {}
variable "vpc_id" {}
variable "subnets" { type = list(string) }
variable "alb_sg_id" {}

# modules/alb/outputs.tf
output "dns_name" {
  value = aws_lb.app_lb.dns_name
}