// Define the IAM role for the EKS cluster
resource "aws_iam_role" "eks_cluster_role" {
  name = "my-eks-cluster-role"

  assume_role_policy = jsondecode({
    Version = "2012-10-17",
    Statement = [
        {
            Action = "sts:AssumeRole",
            Effect = "Allow",
            Principal = {
                Service = "eks.amazonaws.com"
            }
        }
    ]
  })
}

// Attach the AmazonEKSClusterPolicy to the EKS cluster role
resource "aws_iam_policy_attachment" "AmazonEKSClusterPolicy" {
  name = "eks-cluster-attachment"
  policy_arn = "arn:aws:iam::awspolicy/AmazonEKSClusterPolicy"
  roles = [aws_iam_role.eks_cluster_role.name]
}

// Define the IAM role for EKs worker nodes
resource "aws_iam_role" "eks_worker_node_role" {
  name = "eks-worker-node-role"

  assume_role_policy = jsondecode({
    Version ="2012-10-17"
    Statement = [
        {
            Action = "sts:AssumeRole",
            Effect = "Allow",
            Principal = {
                Service = "ec2.amazonaws.com"
            }
        }
    ]
  })
}

// Attach necessary IAM policies to the EKS worker node role
resource "aws_iam_policy_attachment" "AmazonEKSWorkerNodePolicy" {
  name = "eks-worker-node-attachment"
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  roles = [aws_iam_role.eks_worker_node_role.name]
}

resource "aws_iam_policy_attachment" "AmazonEKS_CNI_Policy" {
  name = "eks-cni-attachment"
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  roles = [aws_iam_role.eks_worker_node_role.name]
}

resource "aws_iam_policy_attachment" "AmazonEC2ContainerRegistryReadOnly" {
  name = "eks-vpc-attachment"
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  roles = [aws_iam_role.eks_worker_node_role.name]
}