provider "aws" {
  region = "us-east-1"
}

resource "aws_security_group" "pucpr_security" {
  name="pucpr_security"
  description = "Permitir acesso http e acesso a internet"

  ingress {
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 65535
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "pucpr_server" {
  ami = "ami-06c68f701d8090592"
  instance_type = "t2.nano"

  user_data = file("user_data.sh")

  vpc_security_group_ids = [aws_security_group.pucpr_security.id]
}