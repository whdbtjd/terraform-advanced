variable "vpc_name" {
    description = "The name of the VPC"
}

variable "cidr_numeral" {
    description = "The CIDR numeral for the VPC"
}

variable "billing_tag" {
    description = "The billing tag for the resources"
}

variable "aws_region" {
    default = "ap-northeast-2"
}

variable "shard_id" {
    default = ""
}

variable "shard_short_id" {
    default = ""
}

variable "cidr_numeral_public" {
    default = {
        "0" = "0"
        "1" = "16"
        "2" = "32"
    }
}

variable "cidr_numeral_private" {
    default = {
        "0" = "80"
        "1" = "96"
        "2" = "112"
    }
}

variable "cidr_numeral_db" {
    default = {
        "0" = "160"
        "1" = "176"
        "2" = "192"
    }
}

variable "availability_zones" {
    type      = list(string)
    description = "AZ for the VPC"
}

variable "subnet_no_private" {
    default = "3"
}