provider "aws" {
  region = "ap-south-1"
}
resource aws_instance "instance-1" {
    ami = var.ami_value
    subnet_id=var.subnet_id_value
    instance_type =var.instance_type_value
}