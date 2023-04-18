# provider "aws" {
#     access_key = "access key"
#     secret_key = "secret key"
#     region = "us-east-1"
  
# }

# Define the EKS cluster
resource "aws_eks_cluster" "hkeks" {
  name     = "hkeks-cluster"
  role_arn = aws_iam_role.hkeks_cluster.arn

  vpc_config {
    subnet_ids = aws_subnet.private.*.id
  }

  depends_on = [aws_iam_role_policy_attachment.eks_cluster]
}

# Define the EKS node group
resource "aws_eks_node_group" "hkeksnode" {
  cluster_name    = aws_eks_cluster.hkeks.name
  node_group_name = "hkekeks-node-group"
  node_role_arn   = aws_iam_role.eks_node.arn
  subnet_ids = aws_subnet.private.*.id

  scaling_config {
    desired_size = 1
    max_size     = 1
    min_size     = 1
  }

  depends_on = [aws_iam_role_policy_attachment.eks_node]
}

# Define the IAM roles and policies
resource "aws_iam_role" "hkeks_cluster" {
  name = "hkeks-cluster"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "eks.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "eks_cluster" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.hkeks_cluster.name
}

resource "aws_iam_role" "eks_node" {
  name = "hkeks-node"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "eks_node" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.eks_node.name
}


resource "aws_subnet" "private" {
  count = 1

  cidr_block = "172.31.95.0/24" # Change this to the CIDR block of your choice
  vpc_id     = "vpc-1"
}
