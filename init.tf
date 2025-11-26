terraform {
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "~> 5.17.0" # 5.17.x 버전들만 허용
        }
    }
}

provider "aws" {
    region = "ap-northeast-2"
}

resource "aws_s3_bucket" "tfstate" {
    bucket = "${var.account_id}-apnortheast2-tfstate"

    versioning {
        enabled = true # 버전관리 활성화
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

terraform {
    backend "s3" {
        bucket = "whdbtjd-apnortheast2-tfstate"
        key    = "whdbtjd/terraform/hello"
        region = "ap-northeast-2"
        encrypt = true
        dynamodb_table = "terraform-lock"
    }
}

variable "account_id" {
    default = "whdbtjd"
}