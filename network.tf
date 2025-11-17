resource "aws_vpc" "this" {
  count                = var.create_network ? 1 : 0
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = { Name = "arreglaya-vpc" }
}

resource "aws_internet_gateway" "igw" {
  count  = var.create_network ? 1 : 0
  vpc_id = aws_vpc.this[0].id
  tags   = { Name = "arreglaya-igw" }
}

resource "aws_route_table" "public" {
  count  = var.create_network ? 1 : 0
  vpc_id = aws_vpc.this[0].id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw[0].id
  }
  tags = { Name = "arreglaya-rtb-public" }
}

resource "aws_subnet" "public_a" {
  count                   = var.create_network ? 1 : 0
  vpc_id                  = aws_vpc.this[0].id
  cidr_block              = var.subnet_a_cidr
  availability_zone       = "${var.aws_region}a"
  map_public_ip_on_launch = true
  tags = { Name = "arreglaya-public-us-east-2a" }
}

resource "aws_subnet" "public_b" {
  count                   = var.create_network ? 1 : 0
  vpc_id                  = aws_vpc.this[0].id
  cidr_block              = var.subnet_b_cidr
  availability_zone       = "${var.aws_region}b"
  map_public_ip_on_launch = true
  tags = { Name = "arreglaya-public-us-east-2b" }
}

resource "aws_subnet" "public_c" {
  count                   = var.create_network ? 1 : 0
  vpc_id                  = aws_vpc.this[0].id
  cidr_block              = var.subnet_c_cidr
  availability_zone       = "${var.aws_region}c"
  map_public_ip_on_launch = true
  tags = { Name = "arreglaya-public-us-east-2c" }
}

resource "aws_route_table_association" "a" {
  count          = var.create_network ? 1 : 0
  route_table_id = aws_route_table.public[0].id
  subnet_id      = aws_subnet.public_a[0].id
}
resource "aws_route_table_association" "b" {
  count          = var.create_network ? 1 : 0
  route_table_id = aws_route_table.public[0].id
  subnet_id      = aws_subnet.public_b[0].id
}
resource "aws_route_table_association" "c" {
  count          = var.create_network ? 1 : 0
  route_table_id = aws_route_table.public[0].id
  subnet_id      = aws_subnet.public_c[0].id
}

# Selección de red/subnets (existente o creada)
locals {
  selected_vpc_id = var.create_network ? aws_vpc.this[0].id : var.vpc_id

  selected_public_subnet_ids = var.create_network ? [aws_subnet.public_a[0].id, aws_subnet.public_b[0].id, aws_subnet.public_c[0].id] : var.public_subnet_ids
}