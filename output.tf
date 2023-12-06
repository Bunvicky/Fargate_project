# Output the length of aws_subnet.private and var.private_subnet_cidr for debugging purposes
output "subnet_count" {
  value = length(aws_subnet.private)
}

output "var_subnet_cidr_count" {
  value = length(var.private_subnet_cidr)
}


output "route_table_count" {
  value = length(aws_route_table.private)
}


