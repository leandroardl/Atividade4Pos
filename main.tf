provider "aws" {
  region = "us-west-1"  # Escolha a região desejada
}

resource "aws_instance" "example" {
  ami           = "ami-0dc2d3e4c0f9ebd18"  # AMI do Windows Server 2019
  instance_type = "t2.micro"

  key_name = "my-key"  # Nome da chave SSH configurada na AWS

  tags = {
    Name = "TerraformExample"
  }

  provisioner "remote-exec" {
    inline = [
      "powershell.exe -command \"& { Start-Sleep -s 60; iex (iwr -useb https://chocolatey.org/install.ps1); choco install winrm -y; winrm quickconfig -q; winrm set winrm/config/service/Auth '@{Basic=\"true\"}'; winrm set winrm/config/service '@{AllowUnencrypted=\"true\"}'; winrm set winrm/config/Listener?Address=*+Transport=HTTP '@{Port=5986}'; }\""
    ]
  }

  connection {
    type        = "winrm"
    user        = "Administrator"
    password    = "YourPassword123!"  # Substitua pela senha do administrador
    https       = false
    insecure    = true
  }
}
