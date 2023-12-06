resource "aws_ecr_repository" "main" {
  name = "${var.main.name}-${var.environment}"
  # Other configurations for the ECR repository...
}



variable "environment" {
  description = "Environment for the ECR repository"
  type        = string
  # You can set a default value if needed:
  default = "dev"
}


resource "aws_ecr_lifecycle_policy" "main" {
  repository = aws_ecr_repository.main.name

  policy = jsonencode({
    rules = [{
      rulePriority = 1
      description  = "keep last 10 images"
      action = {
        type = "expire"
      }
      selection = {
        tagStatus   = "any"
        countType   = "imageCountMoreThan"
        countNumber = 10
      }
    }]
  })
}
