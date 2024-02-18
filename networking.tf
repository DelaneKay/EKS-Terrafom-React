// Create VPC
resource "aws_vpc" "acme_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "Acme-vpc"
  }
}

# Create 4 subnets. 2 public and 2 private

resource "aws_subnet" "public_subnet1" {
  vpc_id = aws_vpc.acme_vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "public_subnet1"
  }
}

resource "aws_subnet" "public_subnet2" {
  vpc_id = aws_vpc.acme_vpc.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-east-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "public_subnet2"
  }
}

resource "aws_subnet" "private_subnet1" {
  vpc_id = aws_vpc.acme_vpc.id
  cidr_block = "10.0.3.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "private_subnet1"
  }
}

resource "aws_subnet" "private_subnet2" {
  vpc_id = aws_vpc.acme_vpc.id
  cidr_block = "10.0.4.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "private_subnet2"
  }
}

// Create Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.acme_vpc.id

  tags = {
    Name = "acme-igw"
  }
}

resource "aws_route_table" "public-rt" {
  vpc_id = aws_vpc.acme_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table_association" "public_rt_association1" {
  subnet_id = aws_subnet.public_subnet1.id
  route_table_id = aws_route_table.public-rt.id
}

resource "aws_route_table_association" "public_rt_association2" {
  subnet_id = aws_subnet.public_subnet2.id
  route_table_id = aws_route_table.public-rt.id
}

resource "aws_eip" "eip_nat" {
  domain = "vpc"
}

resource "aws_nat_gateway" "natgw" {
  allocation_id = aws_eip.eip_nat.id
  subnet_id = aws_subnet.public_subnet2.id
}

resource "aws_route_table" "private-rt" {
  vpc_id = aws_vpc.acme_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.natgw.id
  }
}

resource "aws_route_table_association" "private_route_association1" {
  subnet_id = aws_subnet.private_subnet1.id
  route_table_id = aws_route_table.private-rt.id
}

resource "aws_route_table_association" "private_route_association2" {
  subnet_id = aws_subnet.private_subnet2.id
  route_table_id = aws_route_table.private-rt.id
}

module "sgs" {
  source = "./eks-sg"
  vpc_id = aws_vpc.acme_vpc.id

}

module "eks" {
  source = "./eks"
  vpc_id = aws_vpc.acme_vpc.id
  subnet_ids = [aws_subnet.public_subnet1.id, aws_subnet.public_subnet2.id]
  sg_ids = module.sgs.security_group_public
}