resource "aws_vpc" "vpc" {
  cidr_block           = "${lookup(var.vpc_cidr_block, var.tier)}"
  instance_tenancy     = "default"
  enable_dns_hostnames = "true"

  tags = {
    Name = "${var.tier}-vpc"
  }
}

resource "aws_subnet" "pub_subnet1" {
  vpc_id                  = "${aws_vpc.vpc.id}"
  cidr_block              = "${lookup(var.pub_sub1, var.tier)}"
  availability_zone       = "${var.region}a"
  map_public_ip_on_launch = "true"


  tags = {
    Name = "${var.tier}-pub-sub1"
  }
}
resource "aws_subnet" "pub_subnet2" {
  vpc_id                  = "${aws_vpc.vpc.id}"
  cidr_block              = "${lookup(var.pub_sub2, var.tier)}"
  availability_zone       = "${var.region}b"
  map_public_ip_on_launch = "true"

  tags = {
    Name = "${var.tier}-pub-sub2"
  }
}

resource "aws_subnet" "private_subnet1" {
  vpc_id            = "${aws_vpc.vpc.id}"
  cidr_block        = "${lookup(var.private_sub1, var.tier)}"
  availability_zone = "${var.region}a"

  tags = {
    Name = "${var.tier}-private-sub1"
  }
}

resource "aws_subnet" "private_subnet2" {
  vpc_id            = "${aws_vpc.vpc.id}"
  cidr_block        = "${lookup(var.private_sub2, var.tier)}"
  availability_zone = "${var.region}b"

  tags = {
    Name = "${var.tier}-private-sub2"
  }
}


resource "aws_internet_gateway" "gw" {
  vpc_id = "${aws_vpc.vpc.id}"

  tags = {
    Name = "${var.tier}-ng"
  }
}
resource "aws_eip" "nat" {
  vpc = true
}
resource "aws_nat_gateway" "nat_gw" {
  allocation_id = "${aws_eip.nat.id}"
  subnet_id     = "${aws_subnet.pub_subnet1.id}"

  tags = {
    Name = "${var.tier}-ng"
  }
}
resource "aws_route_table" "pub_Subnet_rtb" {
  vpc_id = "${aws_vpc.vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.gw.id}"
  }
  tags = {
    Name = "Public-route"
  }
}
resource "aws_route_table" "private_Subnet_rtb" {
  vpc_id = "${aws_vpc.vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_nat_gateway.nat_gw.id}"
  }
  tags = {
    Name = "Private-route"
  }
}

resource "aws_route_table_association" "public-route" {
  subnet_id      = "${aws_subnet.pub_subnet1.id}"
  route_table_id = "${aws_route_table.pub_Subnet_rtb.id}"
}
resource "aws_route_table_association" "public-route2" {
  subnet_id      = "${aws_subnet.pub_subnet2.id}"
  route_table_id = "${aws_route_table.pub_Subnet_rtb.id}"
}

resource "aws_route_table_association" "private-route" {
  subnet_id      = "${aws_subnet.private_subnet1.id}"
  route_table_id = "${aws_route_table.private_Subnet_rtb.id}"
}
resource "aws_route_table_association" "private-route2" {
  subnet_id      = "${aws_subnet.private_subnet2.id}"
  route_table_id = "${aws_route_table.private_Subnet_rtb.id}"
}