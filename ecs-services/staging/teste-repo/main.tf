# Description: Create ECS Cluster
terraform {
  required_providers {
    template = {
      source  = "hashicorp/template"
      version = "2.2.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "5.46.0"
    }
  }
  backend "s3" {
    bucket = "hype-ecs-terraform-state"
    key    = "services-ecs/staging/teste-repo/terraform.tfstate"
    region = "us-east-1"
  }
}

