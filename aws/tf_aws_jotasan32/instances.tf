resource "aws_instance" "server_a" {
  ami           = "ami-0d5eff06f840b45e9"
  instance_type = "t3.micro"
  subnet_id = aws_subnet.jaime_subnet1a.id
  tags = {
    Name = "server_a"
  }
}

resource "aws_instance" "server_b" {
  ami           = "ami-0d5eff06f840b45e9"
  instance_type = "t3.micro"
  subnet_id = aws_subnet.jaime_subnet2a.id
  tags = {
    Name = "server_b"
  }
}

