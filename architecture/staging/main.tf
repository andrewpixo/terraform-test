module "staging_deploy" {
  source = "../global"
  db_name = "staging"
  db_pass = "password"
  db_user = "admin"
  domain = "example.com"
  app_name = "staging"
}

output "frontend_ip" {
  value = module.staging_deploy.frontend_ip
}
output "backend_ip" {
  value = module.staging_deploy.backend_ip
}
output "frontend_key" {
  value = module.staging_deploy.frontend_key
}
output "backend_key" {
  value = module.staging_deploy.backend_key
}
output "frontend_repository_url" {
  value = module.staging_deploy.frontend_repository_url
}
output "backend_repository_url" {
  value = module.staging_deploy.backend_repository_url
}