data "terraform_remote_state" "vpc" {
  backend = "s3"

  config = {
    bucket = "whdbtjd-apnortheast2-tfstate"
    key    = "whdbtjd/terraform/vpc/hello"
    region = "ap-northeast-2"
    dynamodb_table = "terraform-lock"
  }
}
