# provider "aws" {
#     access_key = "access key"
#     secret_key = "secret key"
#     region = "us-east-1"
  
# }

# Define the ECS cluster
resource "aws_ecs_cluster" "hk1_cluster" {
  name = "hk1-ecs-cluster"
}

# Define the task definition
resource "aws_ecs_task_definition" "hk1_task_definition" {
  family                   = "hk1-task"
  container_definitions    = jsonencode([
    {
      count           = 1
      name  = "my-container"
      image = "nginx:latest"
      memory = 1024
      cpu = 1
      port_mappings = [
        {
          container_port = 80
          host_port      = 80
        }
      ]
    }
  ])
}



# # Define the ECS task
# resource "aws_ecs_task_set" "hk1_task" {
#   task_definition = aws_ecs_task_definition.hk1_task_definition.arn
#   count           = 1
# }

# Define the ECS service
resource "aws_ecs_service" "hkservice" {
  name            = "my-ecs-service"
  cluster         = aws_ecs_cluster.hk1_cluster.id
  task_definition = aws_ecs_task_definition.hk1_task_definition.arn
  desired_count   = 1
}


# Define the ECS cluster
resource "aws_ecs_cluster" "hk2_cluster" {
  name = "hk2-ecs-cluster"
}

# Define the task definition
resource "aws_ecs_task_definition" "hk2_task_definition" {
  family                   = "hk2-task"
  container_definitions    = jsonencode([
    {
      count           = 1
      name  = "my-container"
      image = "nginx:latest"
      memory = 1024
      cpu = 1
      port_mappings = [
        {
          container_port = 80
          host_port      = 80
        }
      ]
    }
  ])
}



# # Define the ECS task
# resource "aws_ecs_task_set" "hk2_task" {
#   task_definition = aws_ecs_task_definition.hk2_task_definition.arn
#   count           = 1
# }

# Define the ECS service
resource "aws_ecs_service" "hkservice2" {
  name            = "my-ecs-service"
  cluster         = aws_ecs_cluster.hk2_cluster.id
  task_definition = aws_ecs_task_definition.hk2_task_definition.arn
  desired_count   = 1
}
