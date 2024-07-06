provider "aws" {
  region = "us-east-1"
}

resource "aws_security_group" "pucpr_security" {
  name="pucpr_security"
  description = "Permitir acesso http e acesso a internet"

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 65535
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_key_pair" "key_pair" {
    key_name = "terraform_keypair"
    public_key = file("~/.ssh/id_rsa.pub")
}

resource "aws_instance" "pucpr_server" {
  ami = "ami-06c68f701d8090592"
  instance_type = "t2.nano"

  user_data = file("user_data.sh")
  key_name = aws_key_pair.key_pair.key_name

  vpc_security_group_ids = ["${aws_security_group.pucpr_security.id}"]
}