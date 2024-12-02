output "vpc_id"{
    value = aws_vpc.my-vpc.id
}

output "route_table_id"{
    value = aws_route_table.my-route-table.id
}