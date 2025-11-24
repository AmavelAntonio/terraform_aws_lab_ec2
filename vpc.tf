resource "aws_vpc" "lab_01_vpc" {
  cidr_block = var.cidr_block_vpc

  tags = {
    Name = var.lab_vpc_name
  }
}

resource "aws_subnet" "lab_01_subnet_pub" {
  vpc_id            = aws_vpc.lab_01_vpc.id
  cidr_block        = var.lab_subnet_pub_cidr_block
  availability_zone = "${var.project_region}a"
  tags = {
    Name = var.lab_subnet_pub_name
  }
}

resource "aws_subnet" "lab_01_subnet_priv" {
  vpc_id            = aws_vpc.lab_01_vpc.id
  cidr_block        = var.lab_subnet_priv_cidr_block
  availability_zone = "${var.project_region}a"

  tags = {
    Name = var.lab_subnet_priv_name
  }
}

resource "aws_internet_gateway" "lab01_igw" {

  tags = {
    Name = var.lab_igw_name
  }
}

resource "aws_internet_gateway_attachment" "vpc_attach_igw" {
  internet_gateway_id = aws_internet_gateway.lab01_igw.id
  vpc_id              = aws_vpc.lab_01_vpc.id
}

resource "aws_eip" "lab01_nat_eip" {
  domain = "vpc"

  depends_on = [aws_internet_gateway.lab01_igw]

  tags = {
    Name = var.lab_nat_eip_name
  }
}

resource "aws_nat_gateway" "lab_01_nat_gtw" {
  allocation_id = aws_eip.lab01_nat_eip.id
  subnet_id     = aws_subnet.lab_01_subnet_pub.id

  tags = {
    Name = var.lab_nat_gtw_name
  }

  depends_on = [aws_internet_gateway.lab01_igw]
}

resource "aws_route_table" "lab_01_pub_rt" {
  vpc_id = aws_vpc.lab_01_vpc.id

  route {
    cidr_block = var.rt_public_cidrs
    gateway_id = aws_internet_gateway.lab01_igw.id
  }

  tags = {
    Name = var.avg_rt_public_name
  }
}

resource "aws_route_table_association" "lab_01_pub_rt_assoc" {
  subnet_id      = aws_subnet.lab_01_subnet_pub.id
  route_table_id = aws_route_table.lab_01_pub_rt.id
}

resource "aws_route_table" "lab_01_priv_rt" {
  vpc_id = aws_vpc.lab_01_vpc.id

  route {
    cidr_block     = var.rt_private_cidrs
    nat_gateway_id = aws_nat_gateway.lab_01_nat_gtw.id
  }

  tags = {
    Name = var.avg_rt_private_name
  }
}

resource "aws_route_table_association" "lab_01_priv_rt_assoc" {
  subnet_id      = aws_subnet.lab_01_subnet_priv.id
  route_table_id = aws_route_table.lab_01_priv_rt.id
}