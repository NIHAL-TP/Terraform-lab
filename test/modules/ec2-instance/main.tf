provider "aws"{
	region ="ap-south-1"
}
variable "ami_id1" {
  description = "value"
}
variable "instance_type1" {
  description = "value"
}
variable "subnet_id1" {
  description = "value"
}
resource "aws_instance" "my_ec2_instance"{
	ami = var.ami_id1
	subnet_id = var.subnet_id1
	instance_type = var.instance_type1
}
