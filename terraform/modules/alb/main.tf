resource "aws_lb" "app_lb" {
  name               = var.name
  internal           = false
  load_balancer_type = "application"
  subnets            = var.subnets
  security_groups    = [var.alb_sg_id]

  tags = {
    Name = var.name
  }
}