output "vpc_id" {
  value = aws_vpc.petclinic.id
}

output "publicsub" {
  value = aws_subnet.publicsub.id
}

output "privatesub" {
    value = aws_subnet.privatesub.id
}

output "gateway_id" {
  value = aws_internet_gateway.petclinic-igw.id
}

output "aws_security_group" {
  value = aws_security_group.petclinic_sg.id
}