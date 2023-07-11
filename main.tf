#this file consists of code for instances and sg
provider "aws" {
region = "us-east-2"
access_key = "AKIAVPQMZL2QIATUMJV3"
secret_key = "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"
}

resource "aws_instance" "one" {
  ami             = "ami-0d1c47ab964ae2b87"
  instance_type   = "t2.micro"
  key_name        = "rahamnewkp01"
  vpc_security_group_ids = [aws_security_group.five.id]
  availability_zone = "us-east-2a"
  user_data       = <<EOF
#!/bin/bash
sudo -i
yum install httpd -y
systemctl start httpd
chkconfig httpd on
echo "hai all this is my app created by terraform infrastructurte by raham sir server-1" > /var/www/html/index.html
EOF
  tags = {
    Name = "web-serverr-1"
  }
}

resource "aws_instance" "two" {
  ami             = "ami-0d1c47ab964ae2b87"
  instance_type   = "t2.micro"
  key_name        = "DevOps-Ohio"
  vpc_security_group_ids = [aws_security_group.five.id]
  availability_zone = "us-east-2b"
  user_data       = <<EOF
#!/bin/bash
sudo -i
yum install httpd -y
systemctl start httpd
chkconfig httpd on
echo "Hi all this is my website created by terraform infrastructurte by raham sir server-2" > /var/www/html/index.html
EOF
  tags = {
    Name = "web-server-2"
  }
}

resource "aws_instance" "three" {
  ami             = "ami-0d1c47ab964ae2b87"
  instance_type   = "t2.micro"
  key_name        = "DevOps-Ohio"
  vpc_security_group_ids = [aws_security_group.five.id]
  availability_zone = "us-east-2a"
  tags = {
    Name = "app-server-1"
  }
}

resource "aws_instance" "four" {
  ami             = "ami-0d1c47ab964ae2b87"
  instance_type   = "t2.micro"
  key_name        = "DevOps-Ohio"
  vpc_security_group_ids = [aws_security_group.five.id]
  availability_zone = "us-east-2b"
  tags = {
    Name = "app-server-2"
  }
}

resource "aws_security_group" "five" {
  name = "elb-sg"
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_s3_bucket" "six" {
  bucket = "rahamshaikterra77889900prodenv"
}

resource "aws_iam_user" "seven" {
for_each = var.user_names
name = each.value
}

variable "user_names" {
description = "*"
type = set(string)
default = ["user1", "user2", "user3", "user4"]
}

resource "aws_ebs_volume" "eight" {
 availability_zone = "us-east-2a"
  size = 40
  tags = {
    Name = "ebs-001"
  }
}
