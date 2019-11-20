resource "aws_nat_gateway" "NatGatway" {
  allocation_id = "${aws_eip.EIP_natgateway.id}"
  subnet_id     = "${aws_subnet.public_Sub1.id}"
  tags = {
    Name = "NatGateway"
  }
}


resource "aws_eip" "EIP_natgateway" {
  vpc = true
}