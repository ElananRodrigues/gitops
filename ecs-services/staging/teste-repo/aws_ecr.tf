# ECR repo name
resource "aws_ecr_repository" "default-name-ecs" {
  name = var.default_name
}