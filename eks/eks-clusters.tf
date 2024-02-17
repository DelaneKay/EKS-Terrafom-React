// Define the EKS cluster
resource "aws_eks_cluster" "my-eks-cluster" {
  name = "my-eks-cluster"
  role_arn = aws_iam_role.eks_cluster_role.arn

  vpc_config {
    subnet_ids = [ var.subnet_id[0],var.subnet_id[1] ]
  }

  depends_on = [ 
    aws_iam_role.eks_cluster_role,
    aws_iam_policy_attachment.AmazonEKSClusterPolicy
   ]
}