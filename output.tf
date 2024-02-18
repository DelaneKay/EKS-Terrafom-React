output "bastion_instance_id" {
  value = aws_instance.bastion.id
}

output "bastion_public_ip" {
  value = aws_instance.bastion.public_ip
}

output "vpc_id" {
  value = aws_vpc.acme_vpc.id
}

output "public_subnet_ids" {
  value = [aws_subnet.public_subnet1.id, aws_subnet.public_subnet2.id]
}

output "security_group_id" {
  value = aws_security_group.acme_sg.id
}
