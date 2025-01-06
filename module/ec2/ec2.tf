

# Reference the existing subnet
data "aws_subnet" "existing" {
  id = var.aws_public_subnet  # Existing subnet ID
}

# Reference the existing route table using filters
data "aws_route_table" "aws_route_table_existing" {
  id = var.aws_route_table # Existing route table ID 
}

# Reference the existing internet gateway using filters
data "aws_internet_gateway" "aws_internet_gateway_existing" {
  id = var.aws_internet_gateway
}

resource "aws_security_group" "allow_all" {
  vpc_id = var.aws_security_group  # Use existing VPC

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 9000
    to_port     = 9000
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "sonarqube" {
  ami           = var.aws_instance  # Provided AMI for Mumbai region
  instance_type = var.instance_type
  subnet_id     = data.aws_subnet.existing.id
  vpc_security_group_ids = [aws_security_group.allow_all.id]
  associate_public_ip_address = true

  tags = {
    Name = "SonarQube"
  }
}

resource "aws_instance" "docker-servr" {
  ami           = var.aws_instance  # Provided AMI for Mumbai region
  instance_type = var.instance_type
  subnet_id     = data.aws_subnet.existing.id
  vpc_security_group_ids = [aws_security_group.allow_all.id]
  associate_public_ip_address = true

  tags = {
    Name = "docker-server"
  }
}

resource "aws_elb" "main" {
  name    = "main-load-balancer"
  subnets = [data.aws_subnet.existing.id]

  listener {
    instance_port     = 80
    instance_protocol = "HTTP"
    lb_port           = 80
    lb_protocol       = "HTTP"
  }

  instances = [
    aws_instance.docker-servr.id,
  ]

  health_check {
    target              = "HTTP:80/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

  tags = {
    Name = "main-load-balancer"
  }
}
