#Creación VPC
resource "aws_vpc" "vpc_proyecto" {
  cidr_block = "10.20.0.0/16"
  tags = {
    Name = "VPC_proyecto"
  }
}

#Creación Subnet Publica
resource "aws_subnet" "public1" {
  vpc_id     = aws_vpc.vpc_proyecto.id
  cidr_block = "10.20.4.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "SNET_publica_proyecto"
  }
}

#Creación Subnets Privadas
resource "aws_subnet" "private1" {
  vpc_id     = aws_vpc.vpc_proyecto.id
  cidr_block = "10.20.5.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "SNET_privada_proyecto"
  }
}

resource "aws_subnet" "private2" {
  vpc_id     = aws_vpc.vpc_proyecto.id
  cidr_block = "10.20.6.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "SNET_privado2"
  }
}

resource "aws_subnet" "private3" {
  vpc_id     = aws_vpc.vpc_proyecto.id
  cidr_block = "10.20.7.0/24"
  availability_zone = "us-east-1c"

  tags = {
    Name = "SNET_privado3"
  }
}