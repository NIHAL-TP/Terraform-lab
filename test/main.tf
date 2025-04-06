provider "aws" {
  region = "ap-south-1"
}

module "ec2_instance" {
  source = "./modules/ec2-instance"
  ami_id1 = var.ami_id1
  subnet_id1 = var.subnet_id1
  instance_type1 = lookup(var.instance_type1,terraform.workspace,"t2.micro")
  
}


