# provider "aws" {
#     access_key = "access key"
#     secret_key = "secret key"
#     region = "us-east-1"
  
# }



module "db1" {
  source  = "terraform-aws-modules/rds/aws"

  identifier = "hkdb-1"

  engine            = "mysql"
  engine_version    = "5.7"
  instance_class    = "db.m5.xlarge"
  allocated_storage = 5

  db_name  = "demodb"
  username = "user"
  port     = "3306"

  iam_database_authentication_enabled = true

 tags = {
      "Name" = "hkec2-1"  
      "created by" = "Girish"
      "approved by" = "Shujat"
      "poc end date" = "20-02-2023"
      "application name" = "RDS"
      "service type" = "RDS"
    }

  # DB subnet group
  create_db_subnet_group = true
  subnet_ids             = ["subnet-1", "subnet-2"]

  # DB parameter group
  family = "mysql5.7"

  # DB option group
  major_engine_version = "5.7"

  # Database Deletion Protection
  deletion_protection = false

  parameters = [
    {
      name = "character_set_client"
      value = "utf8mb4"
    },
    {
      name = "character_set_server"
      value = "utf8mb4"
    }
  ]

  options = [
    {
      option_name = "MARIADB_AUDIT_PLUGIN"

      option_settings = [
        {
          name  = "SERVER_AUDIT_EVENTS"
          value = "CONNECT"
        },
        {
          name  = "SERVER_AUDIT_FILE_ROTATIONS"
          value = "37"
        },
      ]
    },
  ]
}
# module "db_subnet_group" {

#   source  = "github.com/terraform-aws-modules/terraform-aws-rds/tree/v5.6.0/modules/db_subnet_group "
#   version = "3.0.0"

#   name        = "hk-subnet-group"
#   description = "HK subnet group"
  
#   vpc_id      = "vpc-1"

#   subnet_ids = [
#     "subnet-1",
#     "subnet-2",
#     "subnet-3"
#   ]
  
# }
# resource "aws_db_instance" "hkrds" {
#   identifier             = "hk-db"
#   engine                 = "mysql"
#   engine_version         = "8.0.25"
#   instance_class         = "db.t2.micro"
#   allocated_storage      = 20
#   storage_type           = "gp2"
#   username               = "exampleuser"
#   password               = "examplepassword"
#   db_subnet_group_name   = "subnet-1"
#   vpc_security_group_ids = ["${aws_security_group.hkrdss.id}"]
#   tags = {
#       "Name" = "hkec2-1"  
#       "created by" = "Girish"
#       "approved by" = "Shujat"
#       "poc end date" = "20-02-2023"
#       "application name" = "RDS"
#       "service type" = "RDS"
#     }
# }

module "db2" {
  source  = "terraform-aws-modules/rds/aws"

  identifier = "hkdb-2"

  engine            = "mysql"
  engine_version    = "5.7"
  instance_class    = "db.m5.xlarge"
  allocated_storage = 5

  db_name  = "demodb"
  username = "user"
  port     = "3306"

  iam_database_authentication_enabled = true

 tags = {
      "Name" = "hkec2-2"  
      "created by" = "Girish"
      "approved by" = "Shujat"
      "poc end date" = "20-02-2023"
      "application name" = "RDS"
      "service type" = "RDS"
    }

  # DB subnet group
  create_db_subnet_group = true
  subnet_ids             = ["subnet-1", "subnet-1"]

  # DB parameter group
  family = "mysql5.7"

  # DB option group
  major_engine_version = "5.7"

  # Database Deletion Protection
  deletion_protection = false

  parameters = [
    {
      name = "character_set_client"
      value = "utf8mb4"
    },
    {
      name = "character_set_server"
      value = "utf8mb4"
    }
  ]

  options = [
    {
      option_name = "MARIADB_AUDIT_PLUGIN"

      option_settings = [
        {
          name  = "SERVER_AUDIT_EVENTS"
          value = "CONNECT"
        },
        {
          name  = "SERVER_AUDIT_FILE_ROTATIONS"
          value = "37"
        },
      ]
    },
  ]
}

resource "aws_security_group" "hkrdss" {
  name_prefix = "rds-db-hk"
  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
