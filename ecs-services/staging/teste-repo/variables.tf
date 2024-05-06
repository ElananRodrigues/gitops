variable "aws_provider_region" {
  type    = string
  default = "us-east-1"
}

variable "aws_ecs_service_cluster_name" {
  type    = string
  default = "staging"
}

variable "default_name" {
  default = "teste-repo"
}

variable "image" {
  type    = string
  default = "nginx:latest"
}

variable "cpu" {
  default = 256
}

variable "memory" {
  default = 512
}

variable "container_port" {
  type    = number
  default = 80
}

variable "desired_count" {
  type    = number
  default = 1
}

variable "launch_type" {
  type    = string
  default = "EC2"
}

variable "network_mode" {
  type    = string
  default = "bridge"

}

variable "aws_subnet_ids" {
  type    = list(string)
  default = ["subnet-827fb1af", "subnet-0663da4f"]
}

variable "aws_vpc_id" {
  type    = string
  default = "vpc-a2d9e3c5"
}

variable "security_groups" {
  type    = list(string)
  default = ["sg-03735bd2181fcde36"]
}
