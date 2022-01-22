output "vpc_id" {
  description = "ID of project VPC"
  value       = module.network.vpc_id
}

output "private_subnet_1_id" {
    value = module.network.private_subnet_1
}

output "private_subnet_2_id" {
    value = module.network.private_subnet_2
}

output "public_subnet_1_id" {
    value = module.network.public_subnet_1
}

output "public_subnet_2_id" {
    value = module.network.public_subnet_2
}