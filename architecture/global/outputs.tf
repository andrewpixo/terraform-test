output "frontend_ip" {
  value = aws_instance.frontend_instance.public_ip
}
output "backend_ip" {
  value = aws_instance.backend_instance.public_ip
}

output "frontend_key" {
  value = aws_key_pair.frontend_key.public_key
}
output "backend_key" {
  value = aws_key_pair.backend_key.public_key
}
output "frontend_repository_url" {
  value = aws_ecr_repository.frontend_repository.repository_url
}
output "backend_repository_url" {
  value = aws_ecr_repository.backend_repository.repository_url
}

