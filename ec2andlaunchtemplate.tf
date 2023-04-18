# provider "aws" {
#     access_key = "access key"
#     secret_key = "secret key"
#     region = "us-east-1"
  
# }

resource "aws_instance" "hkec2-1" {
    ami = "ami-007868005aea67c54"
    instance_type = "t2.micro"
    tags = {
      "Name" = "hkec2-1"  
      "created by" = "Girish"
      "approved by" = "Shujat"
      "poc end date" = "20-02-2023"
      "application name" = "ec2"
      "service type" = "ec2"
    }
  
}
resource "aws_instance" "hkec2-2" {
    ami = "ami-007868005aea67c54"
    instance_type = "t2.micro"
    tags = {
      "Name" = "hkec2-2"  
      "created by" = "Girish"
      "approved by" = "Shujat"
      "poc end date" = "20-02-2023"
      "application name" = "ec2"
      "service type" = "ec2"
    }
}
resource "aws_launch_template" "hktemplate" {
    name = "hktemplate"
    block_device_mappings {
    device_name = "/dev/sda1"

    ebs {
      volume_size = 20
    }
  }
   network_interfaces {
    associate_public_ip_address = true
  }

  placement {
    availability_zone = "us-east-1a"
  }

  instance_type = "t2.micro"
  key_name = "eks"
  image_id = "ami-007868005aea67c54"
  tags = {
      "Name" = "hkec2-2"  
      "created by" = "Girish"
      "approved by" = "Shujat"
      "poc end date" = "20-02-2023"
      "application name" = "ec2"
      "service type" = "ec2"
    }
}

