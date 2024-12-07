resource "tls_private_key" "MyLinuxBox2" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

data "tls_public_key" "MyLinuxBox2" {
  private_key_pem = tls_private_key.MyLinuxBox2.private_key_pem
}

output "private_key" {
  value     = tls_private_key.MyLinuxBox2.private_key_pem
  sensitive = true
}

output "public_key" {
  value = data.tls_public_key.MyLinuxBox2.public_key_openssh
}

resource "aws_key_pair" "MyLinuxBox2" { #creates a key pair using the public key generated from the tls_private_key. You can use the "terraform output private_key" command to retrieve the value of the output
  key_name = "MyLinuxBox2" 
  public_key = data.tls_public_key.MyLinuxBox2.public_key_openssh 
  }
############################################################################################################################################################################################

  resource "tls_private_key" "MyLinuxBox3" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

data "tls_public_key" "MyLinuxBox3" {
  private_key_pem = tls_private_key.MyLinuxBox3.private_key_pem
}

resource "aws_key_pair" "MyLinuxBox3" {
  provider   = aws.sa-east-1
  key_name   = "MyLinuxBox3"
  public_key = data.tls_public_key.MyLinuxBox3.public_key_openssh
}
output "MyLinuxBox3_private_key" { #terraform output MyLinuxBox3_private_key -> to print private key to std-output
  value     = tls_private_key.MyLinuxBox3.private_key_pem
  sensitive = true
}

