provider "aws" {
  region  = "us-east-1"  # Región actualizada a us-east-1
}

resource "aws_instance" "example" {
  ami           = "ami-01bbc036057fdf301"  # AMI de la máquina virtual de MV Desarrollo
  instance_type = "t2.micro"  # Tipo de instancia de MV Desarrollo
  key_name      = "vockey"  # Nombre de la clave SSH

  tags = {
    Name = "TerraformExample"
  }

  root_block_device {
    volume_size = 20  # Tamaño del disco en GB
    volume_type = "gp2"
  }

  security_groups = ["my_security_group"]  # Creación de un grupo de seguridad
}

resource "aws_security_group" "my_security_group" {
  name        = "my_security_group"
  description = "Allow SSH and HTTP"

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
