resource "aws_ecr_repository" "frontend_repository" {
  name = "backend-repository"
  image_tag_mutability = "MUTABLE"
  tags = {
    project = "terraform-test"
  }
}

resource "aws_ecr_repository" "backend_repository" {
  name = "frontend-repository"
  image_tag_mutability = "MUTABLE"
  tags = {
    project = "terraform-test"
  }
}