resource "aws_internet_gateway" "IGW_RDSVPC" {
  vpc_id = "${aws_vpc.RDS_VPC.id}"

  tags = {
    Name = "IGW_RDSVPC"
  }
}


resource "aws_route_table" "public_RT" {
  vpc_id = "${aws_vpc.RDS_VPC.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.IGW_RDSVPC.id}"
  }

  tags = {
    Name = "public_RT"
  }
}

resource "aws_route_table_association" "public_RT_Associate" {
  subnet_id      = "${aws_subnet.public_Sub1.id}"
  route_table_id = "${aws_route_table.public_RT.id}"
}


resource "aws_route_table" "private_RT" {
  vpc_id = "${aws_vpc.RDS_VPC.id}"

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = "${aws_nat_gateway.NatGatway.id}"
  }

  tags = {
    Name = "private_RT"
  }
}

resource "aws_route_table_association" "private_RT_Associate" {
  subnet_id      = "${aws_subnet.private_Sub1.id}"
  route_table_id = "${aws_route_table.private_RT.id}"
}