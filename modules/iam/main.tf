resource "aws_iam_policy" "eks_operator_cluster_management_policy" {
  name = "EKSOperatorClusterManagementPolicy"
  tags = {
    description = "Policy for EKS cluster management for ServiceOperators group."
  }
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid    = "VisualEditor0",
        Effect = "Allow",
        Action = [
          "eks:DescribeCluster",
          "eks:ListClusters"
        ],
        Resource = [
          "arn:aws:eks:eu-central-1:xxx:cluster/staging",
          "arn:aws:eks:eu-central-1:xxx:cluster/production"
        ]
      }
    ]
  })
}

resource "aws_iam_group" "service_operators" {
  name = "ServiceOperators"
}

resource "aws_iam_policy_attachment" "service_operators_policy_attach" {
  name       = "EKSOperatorClusterManagementPolicyAttachment"
  policy_arn = aws_iam_policy.eks_operator_cluster_management_policy.arn
  groups     = [aws_iam_group.service_operators.name]
}

resource "aws_iam_user" "operators" {
  for_each = toset(var.operator_user_names)
  name     = each.value
}

resource "aws_iam_group_membership" "service_operator_group_membership" {
  for_each = toset(var.operator_user_names)

  name  = "service-operator-${each.key}-membership"
  users = [aws_iam_user.operators[each.key].name]
  group = aws_iam_group.service_operators.name
}

resource "aws_iam_access_key" "user_access_key" {
  for_each = aws_iam_user.operators
  user     = each.value.name
}

