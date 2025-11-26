terraform {
     required_providers {
          aws = {
             source = "hashicorp/aws"
             version = "~> 5.17.0"
          }
     }
}

provider "aws" {
     region = "ap-northeast-2"
}

resource "aws_s3_bucket" "tfstate" {
  bucket = "inflearn-terraform-${var.account_id}"

  versioning {
    enabled = true
  }
}

resource "aws_dynamodb_table" "terraform_state_lock" {
  name         = "terraform-lock"
  hash_key     = "LockID"
  billing_mode = "PAY_PER_REQUEST"

  attribute {
    name = "LockID"
    type = "S"
  }
}

variable "account_id" {
  default = "whdbtjd"
}

terraform {
  backend "s3" {
    bucket         = "inflearn-terraform-whdbtjd"   
    key            = "terraform/terraform.tfstate"   
    region         = "ap-northeast-2"
    dynamodb_table = "terraform-lock"                
    encrypt        = true
  }
}

