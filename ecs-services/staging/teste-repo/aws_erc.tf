resource "aws_ecr_repository" "default_name_ecr_repo" {
  name = var.default_name
  tags = {
    Name="latest_ecr"
  }
}