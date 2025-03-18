provider "aws" {
  region = "ap-south-1"
}

module "ec2_instance" {
  source = "../modularised_ec2/modules/ec2"
  ami_value = "ami-00bb6a80f01f03502"
  subnet_id_value = "subnet-024c2b3185c14e6bd"
  instance_type_value = "t2.micro"
}

output "output-1" {
    value=module.ec2_instance.public-ip
  
}