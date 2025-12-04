terraform {
    backend "s3" {
        bucket = "whdbtjd-apnortheast2-tfstate"
        key    = "whdbtjd/terraform/whdbtjd_apnortheast2/hello"
        region = "ap-northeast-2"
        encrypt = true
        dynamodb_table = "terraform-lock"
    }
}