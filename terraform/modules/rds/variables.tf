

# modules/rds/outputs.tf
output "db_endpoint" {
  value = aws_db_instance.this.endpoint
}

variable "subnet_ids" {
  type = list(string)
}

variable "rds_sg_id" {
  type = string
}

variable "db_username" {
  type = string
}

variable "db_password" {
  type = string
}

variable "db_subnet_group_name" {
  type    = string
  default = "rds-subnet-group"
}

variable "db_parameter_group_name" {
  type    = string
  default = "education"
}

variable "db_parameter_group_family" {
  type    = string
  default = "postgres17"
}

variable "db_parameter_name" {
  type    = string
  default = "log_connections"
}

variable "db_parameter_value" {
  type    = string
  default = "1"
}

variable "db_identifier" {
  type    = string
  default = "education"
}

variable "db_name" {
  type    = string
  default = "dummydb"
}

variable "db_instance_class" {
  type    = string
  default = "db.t3.micro"
}

variable "db_allocated_storage" {
  type    = number
  default = 5
}

variable "db_engine" {
  type    = string
  default = "postgres"
}

variable "db_engine_version" {
  type    = string
  default = "17.4"
}

variable "db_publicly_accessible" {
  type    = bool
  default = true
}

variable "db_skip_final_snapshot" {
  type    = bool
  default = true
}
