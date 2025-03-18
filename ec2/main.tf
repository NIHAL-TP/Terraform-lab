provider "aws" {
    region = "ap-south-1"
}

resource aws_instance "Instance1" {
    ami         = "ami-00bb6a80f01f03502"
    subnet_id = "subnet-024c2b3185c14e6bd"
    key_name = "terraform-instance"
    instance_type ="t2.micro"         
}