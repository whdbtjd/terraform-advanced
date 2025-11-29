resource "aws_vpc" "default" {
    cidr_block = "10.${var.cidr_numeral}.0.0/16"

    tags = {
        Name = "vpc-${var.vpc_name}"
    }
}

# IGW
resource "aws_internet_gateway" "default" {
    vpc_id = aws_vpc.default.id

    tags = {
        Name = "igw-${var.vpc_name}"
    }
}

# NAT
resource "aws_nat_gateway" "nat" {
    count         = length(var.availability_zones)
    allocation_id = element(aws_eip.nat.*.id, count.index)
    subnet_id     = element(aws_subnet.public.*.id, count.index)

    lifecycle {
        create_before_destroy = true
    }

    tags = {
        Name = "NAT-GW${count.index}-${var.vpc_name}"
    }
}

# EIP for NAT
resource "aws_eip" "nat" {
    count  = length(var.availability_zones)
    domain = "vpc"

    lifecycle {
        create_before_destroy = true
    }
}

# PUBLIC SUBNETS
resource "aws_subnet" "public" {
    count              = length(var.availability_zones)
    vpc_id             = aws_vpc.default.id
    cidr_block         = "10.${var.cidr_numeral}.${var.cidr_numeral_public[count.index]}.0/20"
    availability_zone  = element(var.availability_zones, count.index)
    map_public_ip_on_launch = true

    tags = {
        Name = "public${count.index}-${var.vpc_name}"
    }
}

# Route Table for public subnet
resource "aws_route_table" "public" {
    vpc_id = aws_vpc.default.id

    tags = {
        Name = "publicrt-${var.vpc_name}"
    }
}

# Route Table association for public subnet
resource "aws_route_table_association" "public" {
    count          = length(var.availability_zones)
    subnet_id      = element(aws_subnet.public.*.id, count.index)
    route_table_id = aws_route_table.public.id
}

# PRIVATE SUBNETS
resource "aws_subnet" "private" {
    count             = length(var.availability_zones)
    vpc_id            = aws_vpc.default.id
    cidr_block        = "10.${var.cidr_numeral}.${var.cidr_numeral_private[count.index]}.0/20"
    availability_zone = element(var.availability_zones, count.index)

    tags = {
        Name    = "private${count.index}-${var.vpc_name}"
        Network = "Private"
    }
}

# Route Table for private SUBNETS
resource "aws_route_table" "private" {
    count = length(var.availability_zones)
    vpc_id = aws_vpc.default.id

    tags = {
        Name    = "private${count.index}rt-${var.vpc_name}"
        Network = "Private"
    }
}

# Route Table Assocation for private SUBNETS
resource "aws_route_table_association" "private" {
    count          = length(var.availability_zones)
    subnet_id      = element(aws_subnet.private.*.id, count.index)
    route_table_id = element(aws_route_table.private.*.id, count.index)
}

# DB PRIVATE SUBNETS
resource "aws_subnet" "private_db" {
    count             = length(var.availability_zones)
    vpc_id            = aws_vpc.default.id
    cidr_block        = "10.${var.cidr_numeral}.${var.cidr_numeral_private_db[count.index]}.0/20"
    availability_zone = element(var.availability_zones, count.index)

    tags = {
        Name   = "db-private${count.index}-${var.vpc_name}"
        Networ = "Private"
    }
}

# Route Table for DB SUBNETS
resource "aws_route_table" "private_db" {
    count = length(var.availability_zones)
    vpc_id = aws_vpc.default.id

    tags = {
        Name    = "privatedb${count.index}rt-${var.vpc_name}"
        Network = "Private"
    }
}

# Route Table Assocation for DB SUBNETS
resource "aws_route_table_association" "private_db" {
    count          = length(var.availability_zones)
    subnet_id      = element(aws_subnet.private_db.*.id, count.index)
    route_table_id = element(aws_route_table.private_db.*.id, count.index)
}

# routes for internet gateway which will be set in public subnet
resource "aws_route" "public_internet_gateway" {
    route_table_id         = aws_route_table.public.id
    destination_cidr_block = "0.0.0.0/0"
    gateway_id             = aws_internet_gateway.default.id
}

# routes for NAT gateway which will be set in private subnet
resource "aws_route" "private_nat" {
  count                  = length(var.availability_zones)
  route_table_id         = element(aws_route_table.private.*.id, count.index)
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = element(aws_nat_gateway.nat.*.id, count.index)
}
