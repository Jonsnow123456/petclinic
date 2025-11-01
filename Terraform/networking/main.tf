resource "aws_vpc" "petclinic" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"

  tags = {
    Name = "${var.petclinic}-vpc"
  }
}

resource "aws_subnet" "publicsub" {
  vpc_id     = aws_vpc.petclinic.id
  cidr_block = var.public_cidr

  tags = {
    Name = "${var.petclinic}-publicsub"
  }
}

resource "aws_subnet" "privatesub" {
  vpc_id     = aws_vpc.petclinic.id
  cidr_block = var.private_cidr

  tags = {
    Name = "${var.petclinic}-privatesub"
  }
}

resource "aws_internet_gateway" "petclinic-igw" {
  vpc_id = aws_vpc.petclinic.id

  tags = {
    Name = "${var.petclinic}-Gateway"
  }
}

resource "aws_route_table" "petclinic-rt" {
  vpc_id = aws_vpc.petclinic.id

  route {
    cidr_block = ["0.0.0.0/0"]
    gateway_id = aws_internet_gateway.petclinic-igw.id
  }
  tags = {
    Name = "${var.petclinic}-rt"
  }
}

resource "aws_route_table_association" "publicrt" {
  subnet_id      = aws_subnet.publicsub.id
  route_table_id = aws_route_table.petclinic-rt.id
}

resource "aws_security_group" "petclinic_sg" {
  name        = "${var.petclinic}-security-group"
  description = "Allow SSH, HTTP, and MySQL"

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "MySQL"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    # Limit MySQL access to only app server subnet for security - placeholder:
    cidr_blocks = ["10.0.1.0/24"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

