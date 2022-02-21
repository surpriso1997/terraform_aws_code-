variable "repository_name" {
  type        = string
  description = "name of the repository"
}
variable "default_branch" {
  type        = string
  description = "the default branch in the repository"
  default     = "develop"
}
