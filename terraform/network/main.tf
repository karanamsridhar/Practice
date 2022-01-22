resource "aws_vpc" "pets" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"

  tags = {
    Name = "pets"
  }
}
  
resource "aws_subnet" "private_subnet_1" {
  vpc_id     = aws_vpc.pets.id
  cidr_block = var.private_subnet_1_cidr

  tags = {
    Name = "Private Subnet 1"
  }
}

resource "aws_subnet" "private_subnet_2" {
  vpc_id     = aws_vpc.pets.id
  cidr_block = var.private_subnet_2_cidr

  tags = {
    Name = "Private Subnet 2"
  }
}

resource "aws_subnet" "public_subnet_1" {
  vpc_id     = aws_vpc.pets.id
  cidr_block = var.public_subnet_1_cidr

  tags = {
    Name = "Public Subnet 1"
  }
}

resource "aws_subnet" "public_subnet_2" {
  vpc_id     = aws_vpc.pets.id
  cidr_block = var.public_subnet_2_cidr

  tags = {
    Name = "Public Subnet 2"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.pets.id

  tags = {
    Name = "Pets IGW"
  }
}

resource "aws_eip" "pets_eip" {
    vpc      = true
    tags = {
        Name = "Pets EIP"
    }
}

resource "aws_nat_gateway" "pets_nat_gw" {
  allocation_id = aws_eip.pets_eip.id
  subnet_id     = aws_subnet.public_subnet_1.id

  tags = {
    Name = "Pets NAT"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.igw]
}

resource "aws_route_table" "pets_public_route_table" {
  vpc_id = aws_vpc.pets.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "Pets Public RT"
  }
}

resource "aws_route_table" "pets_private_route_table" {
  vpc_id = aws_vpc.pets.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.pets_nat_gw.id
  }

  tags = {
    Name = "Pets Private RT"
  }
}

resource "aws_route_table_association" "pets_public_rta1" {
  subnet_id      = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.pets_public_route_table.id
}

resource "aws_route_table_association" "pets_public_rta2" {
  subnet_id      = aws_subnet.public_subnet_2.id
  route_table_id = aws_route_table.pets_public_route_table.id
}

resource "aws_route_table_association" "pets_private_rta1" {
  subnet_id      = aws_subnet.private_subnet_1.id
  route_table_id = aws_route_table.pets_private_route_table.id
}

resource "aws_route_table_association" "pets_private_rta2" {
  subnet_id      = aws_subnet.private_subnet_2.id
  route_table_id = aws_route_table.pets_private_route_table.id
}