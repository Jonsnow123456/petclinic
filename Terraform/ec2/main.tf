resource "aws_instance" "app_vm" {
  ami                    = "ami-0bdd88bd06d16ba03"  # Amazon Linux 2 AMI (us-east-1)
  instance_type          = "t2.micro"
  key_name               = "project"
  vpc_security_group_ids = [var.aws_security_group]

  tags = {
    Name = "${var.petclinic}.vm"
  }
  depends_on = [ aws_security_group.petclinic_sg.id ]
}

resource "aws_instance" "db_vm" {
  ami                    = "ami-0bdd88bd06d16ba03"
  instance_type          = "t2.micro"
  key_name               = "project"
  vpc_security_group_ids = [var.aws_security_group]

  tags = {
    Name = "${var.petclinic}.db"
  }
  depends_on = [ aws_security_group.petclinic_sg.id ]
}