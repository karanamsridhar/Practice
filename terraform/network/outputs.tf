output "vpc_id" {
  description = "ID of project VPC"
  value       = aws_vpc.pets.id
}

output "private_subnet_1" {
    description = "Private Subnet ID"
    value = aws_subnet.private_subnet_1.id
}

output "private_subnet_2" {
    description = "Private Subnet ID"
    value = aws_subnet.private_subnet_2.id
}

output "public_subnet_1" {
    description = "Public Subnet ID"
    value = aws_subnet.public_subnet_1.id
}

output "public_subnet_2" {
    description = "Public Subnet ID"
    value = aws_subnet.public_subnet_2.id
}