resource "aws_instance" "web1" {
  ami                         = "${lookup(var.amilinux, var.region)}"
  instance_type               = "t2.micro"
  associate_public_ip_address = "true"
  subnet_id                   = "${aws_subnet.public_Sub1.id}"
  availability_zone           = "${data.aws_availability_zones.az_names.names[0]}"
  key_name                    = "${var.key_pair_name}"
  vpc_security_group_ids      = ["${aws_security_group.pub_EC2_SG.id}"]
  tags = {
    Name = "web1"
  }
}


resource "aws_security_group" "pub_EC2_SG" {
  name   = "pub_EC2_SG"
  vpc_id = "${aws_vpc.RDS_VPC.id}"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]

  }
}



resource "aws_instance" "RDS_EC2" {
  ami                    = "${lookup(var.amilinux, var.region)}"
  instance_type          = "t2.micro"
  subnet_id              = "${aws_subnet.private_Sub1.id}"
  availability_zone      = "${data.aws_availability_zones.az_names.names[1]}"
  key_name               = "${var.key_pair_name}"
  vpc_security_group_ids = ["${aws_security_group.private_EC2_SG.id}"]
  user_data              = "${file("${path.module}/user-data/scripts.sh")}"
  tags = {
    Name = "RDS_EC2"
  }
}


resource "aws_security_group" "private_EC2_SG" {
  name        = "private_EC2_SG"
  description = "Allow TLS inbound traffic"
  vpc_id      = "${aws_vpc.RDS_VPC.id}"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    security_groups = ["${aws_security_group.pub_EC2_SG.id}"]
    
  }
  ingress {
      from_port = 3306
      to_port = 3306
      protocol = "TCP"
      security_groups = ["${aws_security_group.pub_EC2_SG.id}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]

  }
}


