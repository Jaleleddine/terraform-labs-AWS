provider "aws" {
  region     = "us-east-1"
  access_key = "AKIAWKK4BYBMYHM5OFPK"
  secret_key = "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"
}


resource "aws_instance" "myec2vm" {
  ami           = "ami-0057d8e6fb0692b80"
  instance_type = "t2.micro"
  key_name      = "jalel-devsecops"
  tags = {
    Name = "ec2-jalel"
  }
  root_block_device {
    delete_on_termination = true
  }
}
