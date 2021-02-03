provider "aws" {
  region     = var.env_vars.aws_region
  access_key = var.env_vars.aws_access_key_id
  secret_key = var.env_vars.aws_secret_access_key
}
