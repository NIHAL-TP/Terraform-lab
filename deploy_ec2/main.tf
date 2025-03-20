provider "aws" {
  region = "ap-south-1"
}
variable "cidr" {
  default = "10.0.0.0/16"
}
resource "aws_key_pair" "key1" {
  key_name = "terraform_demo"
  public_key = file("~/.ssh/id_rsa.pub")
}

resource "aws_vpc" "vpc1" {
  cidr_block = var.cidr
}

resource "aws_subnet" "subnet1" {
  vpc_id = aws_vpc.vpc1.id
  cidr_block = "10.0.0.0/24"
  availability_zone = "ap-south-1a"
  map_public_ip_on_launch = true
}

resource "aws_internet_gateway" "igw1" {
  vpc_id = aws_vpc.vpc1.id
}

resource "aws_route_table" "rt1" {
  vpc_id = aws_vpc.vpc1.id
  route {
    gateway_id = aws_internet_gateway.igw1.id
    cidr_block = "0.0.0.0/0"
  }
}

resource "aws_route_table_association" "rta1" {
  subnet_id = aws_subnet.subnet1.id
  route_table_id = aws_route_table.rt1.id
}

resource "aws_security_group" "sg1" {
  name = "web"
  vpc_id = aws_vpc.vpc1.id

  ingress {
    description = "HTTP from VPC"
    from_port = 5000
    to_port = 5000
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }

  ingress {
    description = "SSH"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    
  }

  egress {
    description = "outbound rule"
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    
  }

  tags = {
    name = "Web-sg"
  }
}

resource "aws_instance" "server" {
    ami = "ami-00bb6a80f01f03502"
    instance_type = "t2.micro"
    associate_public_ip_address = true
    subnet_id = aws_subnet.subnet1.id
    key_name = aws_key_pair.key1.key_name
    vpc_security_group_ids = [aws_security_group.sg1.id]

    connection {
      type = "ssh"
      user = "ubuntu"
      private_key = file("~/.ssh/id_rsa")
      host = self.public_ip
    }
  
  provisioner "file" {
    source = "app.py"
    destination = "/home/ubuntu/app.py"
  }

  provisioner "remote-exec" {
    inline = [ 
    "sudo apt update -y",
    "sudo apt-get install -y python3-pip python3-venv",
    "cd /home/ubuntu",
    "rm -rf venv",
    "python3 -m venv venv",
    "venv/bin/pip3 install flask",
    "nohup venv/bin/python3 /home/ubuntu/app.py > flask.log 2>&1 &"
    ]
  }
}
