module "networking" {
    source = "./networking"
    petclinic = var.petclinic
    vpc_cidr = var.vpc_cidr
    private_cidr = var.private_cidr
    public_cidr = var.public_cidr
}
module "ec2" {
    source = "./EC2"
    petclinic = var.petclinic
    aws_security_group = var.aws_security_group
}