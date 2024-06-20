provider "aws" {
  region = "us-east-2"
}

resource "aws_instance" "strapi" {
  ami                    = "ami-09040d770ffe2224f" # Amazon Linux 2 AMI
  instance_type          = "t2.medium"
  subnet_id              = "subnet-0f8632da3b474a417"
  vpc_security_group_ids = [aws_security_group.Strapi_SG.id]
  tags = {
    Name = "StrapiServer"
  }


  key_name = "strapi_key2"
}



resource "aws_security_group" "Strapi_SG" {
  name        = "Strapi_SG"
  description = "Strapi_SG"

  vpc_id = "vpc-0d4da62efad50eb46" # Replace with your VPC ID

  // Inbound rules (ingress)
  ingress {
    description = "Allow HTTP inbound traffic"
    from_port   = 1337
    to_port     = 1337
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow traffic from all sources (for example)
  }

  ingress {
    description = "Allow SSH inbound traffic"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Replace with your specific IP or range
  }
    // Outbound rules (egress)
  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"] # Allow all outbound traffic to all destinations
  }
}

output "instance_ip" {
  value = aws_instance.strapi.public_ip
}

 
