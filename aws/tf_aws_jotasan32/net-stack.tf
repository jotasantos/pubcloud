provider "aws" {
  region = "us-east-1"
}
# CREATE VPCs
resource "aws_vpc" "jaime_vpc1" {
  cidr_block       = "172.32.0.0/16"
  tags = {
    Name = "jaime_vpc1"
  }
}
resource "aws_vpc" "jaime_vpc2" {
  cidr_block       = "172.33.0.0/16"
  tags = {
    Name = "jaime_vpc2"
  }
}
# CREATE GATEWAYs
resource "aws_internet_gateway" "jaime_gw1" {
  vpc_id = aws_vpc.jaime_vpc1.id
  tags = {
    Name = "jaime_gw1"
  }
}
resource "aws_internet_gateway" "jaime_gw2" {
  vpc_id = aws_vpc.jaime_vpc2.id
  tags = {
    Name = "jaime_gw2"
  }
}
# CREATE SUBNETs
resource "aws_subnet" "jaime_subnet1a" {
  vpc_id     = aws_vpc.jaime_vpc1.id
  cidr_block = "172.32.0.0/24"

  tags = {
    Name = "jaime_subnet1a"
  }
}
resource "aws_subnet" "jaime_subnet2a" {
  vpc_id     = aws_vpc.jaime_vpc2.id
  cidr_block = "172.33.0.0/24"
  tags = {
    Name = "jaime_subnet2a"
  }
}
# ROUTE TABLES
resource "aws_route_table" "jaime_rt1a" {
  vpc_id = aws_vpc.jaime_vpc1.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.jaime_gw1.id
  }
  tags = {
    Name = "jaime_rt1a"
  }
}
resource "aws_route_table" "jaime_rt2a" {
  vpc_id = aws_vpc.jaime_vpc2.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.jaime_gw2.id
  }
  tags = {
    Name = "jaime_rt2a"
  }
}
# ASSOCIATE RT AND SUBNETS
resource "aws_route_table_association" "jaime_rt_assoc_1a" {
  subnet_id = aws_subnet.jaime_subnet1a.id
  route_table_id = aws_route_table.jaime_rt1a.id

}
resource "aws_route_table_association" "jaime_rt_assoc_2a" {
  subnet_id = aws_subnet.jaime_subnet2a.id
  route_table_id = aws_route_table.jaime_rt2a.id

}
#resource "aws_instance" "server1" {
#  ami           = "ami-0d5eff06f840b45e9"
#  instance_type = "t3.micro"
#
#  tags = {
#    Name = "instance_one"
#    mytag= "this_is_my_tag_one"
#  }
#}
#
#resource "aws_instance" "server2" {
#  ami           = "ami-0d5eff06f840b45e9"
#  instance_type = "t3.micro"
#
#  tags = {
#    Name = "instance_two"
#    mytag= "this_is_my_tag_one"
#  }
#}

