

variable "region" {
  description = "Default region for provider"
  type        = string
  default     = "us-east-2"
}

variable "environment_name" {
  description = "Deployment environment (qa/staging/production)"
  type        = string
  default     = "qa"
}

variable "app_name" {
  description = "Name of the web application"
  type        = string
  default     = "terraform_test"
}

variable "instance_type" {
  description = "ec2 instance type"
  type = string
  default = "t2.micro"
}

variable "create_dns_zone" {
  description = "If true, create new route53 zone, if false read existing route53 zone"
  type        = bool
  default     = false
}

variable "domain" {
  description = "Domain for website"
  type        = string
}

variable "db_name" {
  description = "Name of DB"
  type        = string
}

variable "db_user" {
  description = "Username for DB"
  type        = string
}

variable "db_pass" {
  description = "Password for DB"
  type        = string
  sensitive   = true
}