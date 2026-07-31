resource "aws_internet_gateway" "main" {
  vpc_id = var.vpc_id

  tags = merge(var.tags, {
    Name        = "${var.name_prefix}-igw"
    Environment = var.environment
  })
}

resource "aws_subnet" "public" {
  vpc_id                  = var.vpc_id
  cidr_block              = var.public_subnet_cidr
  availability_zone       = var.availability_zone
  map_public_ip_on_launch = var.map_public_ip_on_launch

  tags = merge(var.tags, {
    Name        = "${var.name_prefix}-public-subnet"
    Environment = var.environment
  })
}

resource "aws_route_table" "public" {
  vpc_id = var.vpc_id

  tags = merge(var.tags, {
    Name        = "${var.name_prefix}-public-rt"
    Environment = var.environment
  })
}

resource "aws_route" "public_internet" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = var.public_route_destination_cidr
  gateway_id             = aws_internet_gateway.main.id
}

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}
