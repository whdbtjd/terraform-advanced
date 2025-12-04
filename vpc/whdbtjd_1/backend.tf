terraform {
    backend "s3" {
        bucket = "whdbtjd-apnortheast2-tfstate"
        key    = "whdbtjd/terraform/vpc/hello"
        region = "ap-northeast-2"
        encrypt = true
        dynamodb_table = "terraform-lock"
    }
}