data "aws_iam_policy_document" "task_exec_assume" {
  statement {
    actions = ["sts:AssumeRole"]
    principals { 
      type = "Service" 
      identifiers = ["ecs-tasks.amazonaws.com"] 
    }
  }
}

resource "aws_iam_role" "task_execution" {
  name               = "arreglaya-ecsTaskExecutionRole"
  assume_role_policy = data.aws_iam_policy_document.task_exec_assume.json
}

resource "aws_iam_role_policy_attachment" "exec_ecr" {
  role       = aws_iam_role.task_execution.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

data "aws_iam_policy_document" "secrets_access" {
  statement {
    sid     = "ReadDBSecrets"
    effect  = "Allow"
    actions = ["secretsmanager:GetSecretValue","secretsmanager:DescribeSecret"]
    resources = [
      aws_secretsmanager_secret.db_prod_password.arn,
      aws_secretsmanager_secret.db_stg_password.arn
    ]
  }
}

resource "aws_iam_policy" "secrets_access" {
  name   = "arreglaya-ecs-secrets-access"
  policy = data.aws_iam_policy_document.secrets_access.json
}

resource "aws_iam_role_policy_attachment" "exec_secrets" {
  role       = aws_iam_role.task_execution.name
  policy_arn = aws_iam_policy.secrets_access.arn
}