# provider "aws" {
#     access_key = "access key"
#     secret_key = "secret key"
#     region = "us-east-1"
  
# }

resource "aws_autoscaling_group" "hkasg-1" {
  name = "hkasg1"
  vpc_zone_identifier = ["subnet-07a16cd1b1a773290"]
  launch_template {
    id = aws_launch_template.hktemplate.id
    version = "$Latest"
    
  }
  min_size = 1
  max_size = 1
  desired_capacity = 1
  health_check_type = "EC2"
  health_check_grace_period = 300
  
  
}

resource "aws_autoscaling_group" "hkasg-2" {
  name = "hkasg2"
  vpc_zone_identifier = ["subnet-07a16cd1b1a773290"]
  launch_template {
    id = aws_launch_template.hktemplate.id
    version = "$Latest"
  }
  min_size = 1
  max_size = 1
  desired_capacity = 1
  health_check_type = "EC2"
  health_check_grace_period = 300
}




