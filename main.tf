provider "aws" {
  profile = "default"
  region  = "us-west-1"
}

# Definir o security group
resource "aws_security_group" "Atividade4Pos_sg" {
  name        = "Atividade_4_Pos_security_group"
  description = "Security group to allow ports 80 and 22"

  # Liberar a porta 80 para qualquer origem
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  # Liberar a porta 22 para qualquer origem
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  # Liberar a porta 3389 para qualquer origem
  ingress {
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  # Liberar a porta 5986 para qualquer origem
  ingress {
    from_port   = 5986
    to_port     = 5986
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }  
  # Habilitar todo o tráfego de saída
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"  # -1 significa todos os protocolos
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "Atividade4Pos" {
  ami           = "ami-0b91b25c68803358e"
  instance_type = "t2.micro"
  
  # Associar o security group
  vpc_security_group_ids = [aws_security_group.atividade4_sg.id]

  # Adicionar o par de chaves existente
  key_name = "Atividade4Pos"  # Substitua pelo nome do seu par de chaves existente
}
