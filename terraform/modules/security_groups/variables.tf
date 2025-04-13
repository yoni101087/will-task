variable "vpc_id" {
  type = string
}

variable "rds_sg_name" {
  type    = string
  default = "rds-sg"
}

variable "rds_sg_description" {
  type    = string
  default = "Allow EKS to access RDS"
}

variable "rds_ingress_port" {
  type    = number
  default = 5432
}

variable "rds_ingress_cidr_blocks" {
  type    = list(string)
  default = ["0.0.0.0/0"]
}

variable "alb_sg_name" {
  type    = string
  default = "alb-sg"
}

variable "alb_sg_description" {
  type    = string
  default = "Allow HTTP/HTTPS traffic"
}

variable "alb_ingress_cidr_blocks" {
  type    = list(string)
  default = ["0.0.0.0/0"]
}
