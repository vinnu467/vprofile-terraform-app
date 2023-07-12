# Create VPC, Internet Gateway, and Route Table
resource "aws_vpc" "vprofile-app" {
  cidr_block = var.vpc_cidr
    enable_dns_hostnames = true
    enable_dns_support   = true

  tags = {
    Name = "vprofile-app-VPC"
    }
}

resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.vprofile-app.id
}

resource "aws_route_table" "my_route_table" {
 vpc_id = aws_vpc.vprofile-app.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_igw.id
  }
}

# Create public subnets
resource "aws_subnet" "public_subnet" {
  count             = 3
  vpc_id            = aws_vpc.vprofile-app.id
  cidr_block        = var.public_subnet_cidrs[count.index]
  availability_zone = var.availability_zones[count.index]

  tags = {
    Name = "public_subnet_${count.index}"
  }
}

# Create private subnets
resource "aws_subnet" "private_subnet" {
  count             = length(var.private_subnet_cidrs)
  vpc_id            = aws_vpc.vprofile-app.id
  cidr_block        = var.private_subnet_cidrs[count.index]
  availability_zone = var.availability_zones[count.index]

  tags = {
    Name = "private_subnet_${count.index}"
  }
}