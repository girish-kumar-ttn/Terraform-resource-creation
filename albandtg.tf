# provider "aws" {
#     access_key = "access key"
#     secret_key = "secret key"
#     region = "us-east-1"
  
# }

resource "aws_security_group" "hkalb_sg" {
  name_prefix = "hkalb-sg"
  tags = {
      "Name" = "hkec2-1"  
      "created by" = "Girish"
      "approved by" = "Shujat"
      "poc end date" = "20-02-2023"
      "application name" = "sg"
      "service type" = "sg"
    }
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_lb" "hkalb" {
  name = "hk-alb"
  tags = {
      "Name" = "hkec2-1"  
      "created by" = "Girish"
      "approved by" = "Shujat"
      "poc end date" = "20-02-2023"
      "application name" = "alb"
      "service type" = "alb"
    }
  internal = false
  load_balancer_type = "application"
  security_groups = [aws_security_group.hkalb_sg.id]
  subnets = ["subnet-1", "subnet-2"] # Replace with your desired subnets
}

resource "aws_lb_target_group" "hk_group" {
  name_prefix = "hk-tg"
  tags = {
      "Name" = "hkec2-1"  
      "created by" = "Girish"
      "approved by" = "Shujat"
      "poc end date" = "20-02-2023"
      "application name" = "tg"
      "service type" = "tg"
    }
  port = 80
  protocol = "HTTP"
  vpc_id = "vpc-1" # Replace with your VPC ID
}

resource "aws_lb_listener" "hkalb_listener" {
  load_balancer_arn = aws_lb.hkalb.arn
  port = "80"
  protocol = "HTTP"

  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.hk_group.arn
  }
}
