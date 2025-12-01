### S3 Endpoint
resource "aws_vpc_endpoint" "s3_endpoint" {
    vpc_id       = aws_vpc.default.id
    service_name = "com.amazonaws.${var.aws_region}.s3"

    tags = {
        Name = "s3-${var.shard_id}"
    }
}

resource "aws_vpc_endpoint_route_table_association" "s3_endpoint_routetable" {
    count           = length(var.availability_zones)
    vpc_endpoint_id = aws_vpc_endpoint.s3_endpoint.id
    route_table_id  = element(aws_route_table.private.*.id, count.index)
}


### DynamoDB Endpoint
resource "aws_vpc_endpoint" "dynamodb_endpoint" {
    vpc_id = aws_vpc.default.id
    service_name = "com.amazonaws.${var.aws_region}.dynamodb"

    tags = {
        Name = "dynamodb-${var.shard_id}"
    }
}

resource "aws_vpc_endpoint_route_table_association" "dynamodb_endpoint_routetable"{
    count = length(var.availability_zones)
    vpc_endpoint_id = aws_vpc_endpoint.dynamodb_endpoint.id
    route_table_id = element(aws_route_table.private.*.id,count.index)
}