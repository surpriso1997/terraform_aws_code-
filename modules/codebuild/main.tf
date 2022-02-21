#  iam roles for code build


#  assume role 

resource "aws_iam_role" "iam_role_for_codebuild" {
  name               = "AWSIamRoleForCodeBuild"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "codebuild.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
    EOF
}


resource "aws_iam_role_policy" "codebuild_policy" {
  name   = "AWSCodeBuildAllPolicies"
  role   = aws_iam_role.iam_role_for_codebuild.name
  policy = <<EOF
{
    "Version" :"2012-10-17",
    "Statement":[
    {
      "Effect": "Allow",
      "Resource": [
        "*"
      ],
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ]
    }

    ]
}
  EOF
}













resource "aws_codebuild_project" "build" {
  name = var.project_name


  depends_on = [
    aws_iam_role.iam_role_for_codebuild
  ]

  resource_access_role = aws_iam_role.iam_role_for_codebuild.arn

  description   = var.description
  badge_enabled = true


  source {
    type            = lookup(var.source_repository, "source_type")
    location        = lookup(var.source_repository, "url")
    git_clone_depth = 1
    git_submodules_config {
      fetch_submodules = false
    }

  }
  source_version = "master"

  environment {
    compute_type = "BUILD_GENERAL1_SMALL"

    image                       = "aws/codebuild/standard:1.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"


    dynamic "environment_variable" {
      for_each = var.env_vars
      content {
        name  = environment_variable.key
        value = environment_variable.value
      }
    }

  }

  cache {
    type  = "LOCAL"
    modes = ["LOCAL_DOCKER_LAYER_CACHE", "LOCAL_SOURCE_CACHE"]
  }

  artifacts {
    type = "NO_ARTIFACTS"
  }
  service_role = aws_iam_role.iam_role_for_codebuild.arn
}

