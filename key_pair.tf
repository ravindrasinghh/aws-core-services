resource "tls_private_key" "demo_key_1" {
  algorithm = "RSA"
  rsa_bits  = "4096"
}

resource "aws_key_pair" "demo_key_1" {
  key_name   = "demo-key-1"
  public_key = tls_private_key.demo_key_1.public_key_openssh
}

resource "local_file" "local_ssh_private_key" {
  content         = tls_private_key.demo_key_1.private_key_pem
  filename        = "ssh-key-private.pem"
  file_permission = "0400"
}

resource "local_file" "local_ssh_public_key" {
  content         = tls_private_key.demo_key_1.public_key_openssh
  filename        = "ssh-key-public.pem"
  file_permission = "0400"
}

resource "aws_instance" "web" {
  key_name               = aws_key_pair.demo_key_1.key_name
}
