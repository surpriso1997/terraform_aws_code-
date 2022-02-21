
output "repo_id" {
  value = aws_codecommit_repository.code_repo.repository_id

}

output "clone_url_ssh" {
  value = aws_codecommit_repository.code_repo.clone_url_ssh
}

output "clone_url_http" {
  value = aws_codecommit_repository.code_repo.clone_url_http
}
