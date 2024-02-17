data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name = "name"
    values = [ "ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*" ]
  }

  filter {
    name = "virtualization-type"
    values = [ "hvm" ]
  }

  owners = [ "515386562013" ] # Canonical
}

data "aws_key_pair" "existing_key_pair" {
  key_name = "AWSDevOPs"
}

resource "aws_instance" "bastion" {
  ami = data.aws_ami.ubuntu.id
  key_name = data.aws_key_pair.existing_key_pair.key_name
  instance_type = var.instance_type
  associate_public_ip_address = true
  subnet_id = aws_subnet.public_subnet1.id
  vpc_security_group_ids = [ aws_security_group.acme_sg.id ]
  tags = {
    Name = "bastion-instance"
  }
}

