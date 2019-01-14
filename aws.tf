### Credentials ###
provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region     = "${var.aws_region}"
}


### VPC ###
resource "aws_vpc" "default" {
  cidr_block = "${var.vpc_cidr_block}"
  tags {
       Name = "vpc_default"
  }
}


### Internet Gateway ###
resource "aws_internet_gateway" "default" {
  vpc_id = "${aws_vpc.default.id}"
  tags {
       Name = "igw_default"
  }
}


### Route Table ###
resource "aws_route" "internet_access" {
  route_table_id         = "${aws_vpc.default.main_route_table_id}"
  destination_cidr_block = "${var.route_table_destination_cidr}"
  gateway_id             = "${aws_internet_gateway.default.id}"
}


### Create Subnet ###
resource "aws_subnet" "default" {
  vpc_id                  = "${aws_vpc.default.id}"
  cidr_block              = "${var.subnet_cidr}"
  map_public_ip_on_launch = true
  tags {
       Name = "subnet_default"
  }
}


### Create Security Group ###
resource "aws_security_group" "default" {
  name        = "security_group_default"
  description = "security_group"
  vpc_id      = "${aws_vpc.default.id}"

  #SSH access from anywhere
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  #outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags {
       Name = "security_group_default"
  }
}


### Create Instance ###
resource "aws_instance" "default" {
  count         = "${var.instance_count}"
  ami           = "${var.aws_amis}"
  instance_type = "${var.instance_type}"
  key_name      = "${var.key_name}"
  subnet_id = "${aws_subnet.default.id}"
  vpc_security_group_ids = ["${aws_security_group.default.id}"]
  tags {
        Name = "Prueba"
  }
  ebs_block_device {
    device_name = "/dev/sda1"
    volume_size = "10"
    volume_type = "gp2"
    delete_on_termination = true
  }    
    volume_tags {
        Name = "ebs_volume_0"
    }
}

### Extra EBS ####
resource "aws_volume_attachment" "ebs_att" {
  device_name = "/dev/sdb"
  volume_id   = "${aws_ebs_volume.ebs_volume.id}"
  instance_id = "${aws_instance.default.id}"
}

resource "aws_ebs_volume" "ebs_volume" {
    size = "10"
    availability_zone = "${aws_instance.default.availability_zone}"
    type = "gp2"
    tags {
        Name = "ebs_volume_1"
    }
}
