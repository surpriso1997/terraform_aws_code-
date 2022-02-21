

terraform {
  required_version = "~>1.1.5"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.71.0"
    }
  }
}
provider "aws" {
  region                  = "us-east-1"
  shared_credentials_file = "/home/manish/.aws/credentials"
  profile                 = "admin"
}

module "code_commit" {
  source          = "./modules/codecommit"
  repository_name = "backend_repo"
  default_branch  = "develop"
}


module "code_build" {

  source       = "./modules/codebuild"
  project_name = "nodal-backend-build-pipeline"
  description  = "this the build of bakcedn"
  env_vars = {
    DATABSE_URL = "DATABASE_URL"
  }
  source_repository = {
    source_type = "CODECOMMIT"
    url         = module.code_commit.clone_url_http
  }

}

