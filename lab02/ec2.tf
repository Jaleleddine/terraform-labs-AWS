provider "aws" {
  region     = "us-east-1"
  access_key = "XXXXXXXXXXXXXX"
  secret_key = "XXXXXXXXXXXXXX"
}


 
resource "aws_instance" "myec2" {
  ami           = data.aws_ami.ec2_ami.id
  instance_type   = var.instancetype
  key_name = "XXXXXXXXXXXXXX-devsecops"
  
  tags = var.aws_common_tag
  security_groups = ["${aws_security_group.security_group.name}"]
  root_block_device {
    delete_on_termination = true
  }
}



data "aws_ami" "ec2_ami" {
  most_recent = true 
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}



resource "aws_security_group" "security_group" {
  name        = "allow_http_https"
  description = "allow inbound outbount traffic"
  ingress {
    description = "http"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "https"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_eip" "lb" {
  instance = aws_instance.myec2.id
  vpc      = true
}
