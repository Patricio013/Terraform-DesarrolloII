resource "aws_ecr_repository" "backend_prod" {
  name                 = var.ecr_backend_prod_repo_name
  image_tag_mutability = "MUTABLE"
}
resource "aws_ecr_repository" "frontend_prod" {
  name                 = var.ecr_frontend_prod_repo_name
  image_tag_mutability = "MUTABLE"
}
resource "aws_ecr_repository" "backend_stg" {
  name                 = var.ecr_backend_stg_repo_name
  image_tag_mutability = "MUTABLE"
}
resource "aws_ecr_repository" "frontend_stg" {
  name                 = var.ecr_frontend_stg_repo_name
  image_tag_mutability = "MUTABLE"
}

output "ecr_backend_prod_url"  { value = aws_ecr_repository.backend_prod.repository_url }
output "ecr_frontend_prod_url" { value = aws_ecr_repository.frontend_prod.repository_url }
output "ecr_backend_stg_url"   { value = aws_ecr_repository.backend_stg.repository_url }
output "ecr_frontend_stg_url"  { value = aws_ecr_repository.frontend_stg.repository_url }