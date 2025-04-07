resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "subnet1" {
  availability_zone = "ap-south-1a"
  vpc_id = aws_vpc.my_vpc.id
  cidr_block = "10.0.0.0/24"
  map_public_ip_on_launch = true
}

resource "aws_subnet" "subnet2" {
  availability_zone = "ap-south-1b"
  vpc_id = aws_vpc.my_vpc.id
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = true
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.my_vpc.id
}

resource "aws_route_table" "RT" {
    vpc_id = aws_vpc.my_vpc.id

    route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table_association" "rta1" {
  subnet_id = aws_subnet.subnet1.id
  route_table_id = aws_route_table.RT.id
}

resource "aws_route_table_association" "rta2" {
  subnet_id = aws_subnet.subnet2.id
  route_table_id = aws_route_table.RT.id
}

resource "aws_security_group" "webSg" {
  name_prefix = "Web-sg-"
  vpc_id = aws_vpc.my_vpc.id

  ingress {
    description = "Tls from vpc"
    protocol = "tcp"
    from_port = "80"
    to_port = "80"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Http from vpc"
    protocol = "TCP"
    from_port = "22"
    to_port = "22"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "outbound traffic"
    protocol = "-1"
    from_port = "0"
    to_port = "0"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "websg"
  }
}

resource "aws_instance" "server1" {
  ami = var.ami_1
  subnet_id = aws_subnet.subnet1.id
  instance_type = var.instance_type_1
  vpc_security_group_ids = [aws_security_group.webSg.id]
  user_data = filebase64("apache_server1.sh")
  tags = {
    Name = "web-server1"
  }
}

resource "aws_instance" "server2" {
  ami = var.ami_1
  subnet_id = aws_subnet.subnet2.id
  instance_type = var.instance_type_1
  vpc_security_group_ids = [aws_security_group.webSg.id]
  user_data = filebase64("nginx_server2.sh")
  tags = {
    Name = "web-server2"
  }
}

resource "aws_s3_bucket" "my_bucket" {
  bucket = "nihals-server-bucket"
}

#alb

resource "aws_lb" "my_alb" {
  name = "my-alb"
  internal = false
  load_balancer_type = "application"
  security_groups = [aws_security_group.webSg.id]
  subnets = [aws_subnet.subnet1.id,aws_subnet.subnet2.id]
  tags = {
    name = "web"
  }
}

resource "aws_lb_target_group" "alb_tg" {
  vpc_id = aws_vpc.my_vpc.id
  name = "alb-tg"
  port = 80
  protocol = "HTTP"

  health_check {
    port = "traffic-port"
    path = "/"
  }
}

resource "aws_lb_target_group_attachment" "alb_tg_attach1" {
    target_id = aws_instance.server1.id
    target_group_arn = aws_lb_target_group.alb_tg.arn
    port = 80
}
resource "aws_lb_target_group_attachment" "alb_tg_attach2" {
    target_id = aws_instance.server2.id
    target_group_arn = aws_lb_target_group.alb_tg.arn
    port = 80
}

resource "aws_lb_listener" "alb_listener" {
  load_balancer_arn = aws_lb.my_alb.arn
  port = 80
  protocol = "HTTP"
  default_action {
    target_group_arn = aws_lb_target_group.alb_tg.arn
    type = "forward"
    
  }
}