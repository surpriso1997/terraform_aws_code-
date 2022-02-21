variable "project_name" {
  type        = string
  description = "code build project name"
}

variable "description" {
  type        = string
  description = "the description for the build project"
}

variable "artifacts" {
  type    = string
  default = "NO_ARTIFACTS"

}

variable "env_vars" {
  type    = map(any)
  default = {}
}

variable "source_repository" {
  type        = map(string)
  description = "the type and location fo the  repostiory github/codecommit/gitlab"

}




