resource "aws_vpc" "RDS_VPC" {
  cidr_block       = "${var.vpc_cidr}"
  instance_tenancy = "${var.vpc_tenancy}"

  tags = {
    Name = "RDS VPC"
  }
}


resource "aws_subnet" "public_Sub1" {
  #count = "${length(data.aws_availability_zones.az_names.names)}"
  vpc_id            = "${aws_vpc.RDS_VPC.id}"
  cidr_block        = "${cidrsubnet(aws_vpc.RDS_VPC.cidr_block, 8, 0)}"
  availability_zone = "${data.aws_availability_zones.az_names.names[0]}"
  tags = {
    Name = "public_Sub1"
  }
}


resource "aws_subnet" "private_Sub1" {
  #count = "${length(data.aws_availability_zones.az_names.names)}"
  vpc_id            = "${aws_vpc.RDS_VPC.id}"
  cidr_block        = "${cidrsubnet(aws_vpc.RDS_VPC.cidr_block, 8, 1)}"
  availability_zone = "${data.aws_availability_zones.az_names.names[1]}"
  tags = {
    Name = "private_Sub1"
  }
}