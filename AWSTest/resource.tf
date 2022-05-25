

resource "aws_vpc" "myvpc" {
  cidr_block = "192.168.200.0/24"
}

resource "aws_subnet" "myvpcsubnet" {
  vpc_id = aws_vpc.myvpc.id
  cidr_block = "192.168.200.0/24"
}

resource "aws_internet_gateway" "mygateway" {
  vpc_id = aws_vpc.myvpc.id
   }


resource "aws_instance" "mywebapp" {
  ami = "ami-079b5e5b3971bd10d"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.myvpcsubnet.id
  key_name = "Windowskey"
}

resource "aws_security_group" "mysecuritygroup" {
  vpc_id = aws_vpc.myvpc.id

   ingress {
    description      = "TLS from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = [aws_vpc.myvpc.cidr_block]
   }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
}