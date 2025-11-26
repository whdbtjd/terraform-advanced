resource "aws_vpc" "default" {
    cidr_block     ="10.${var.cidr_numeral}.0.0/16"

    tags = {
        Name = "vpc-${var.vpc_name}"
    }
}