resource "aws_security_group" "acme_sg" {
  name = "acme-security-group"
  vpc_id = aws_vpc.acme_vpc.id
}

resource "aws_security_group_rule" "ssh_inbound" {
  type = "ingress"
  from_port = "22"
  to_port = "22"
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = aws_security_group.acme_sg.id
}

resource "aws_security_group_rule" "downloads" {
  type = "egress"
  from_port = "0"
  to_port = "0"
  protocol = "-1"
  cidr_blocks = [ "0.0.0.0/0" ]
  ipv6_cidr_blocks = [ "::/0" ]
  security_group_id = aws_security_group.acme_sg.id
}