

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
}
resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr_block
  # Other VPC configurations...
}

resource "aws_subnet" "private" {
  count             = length(var.availability_zones)
  vpc_id            = aws_vpc.main.id
  cidr_block        = cidrsubnet(var.vpc_cidr_block, 8, count.index)
  availability_zone = element(var.availability_zones, count.index)
  # Other subnet configurations...
}

resource "aws_subnet" "public" {
  count             = length(var.availability_zones)
  vpc_id            = aws_vpc.main.id
  cidr_block        = cidrsubnet(var.vpc_cidr_block, 8, count.index + 100)  # Offset CIDR block
  availability_zone = element(var.availability_zones, count.index)
  # Other subnet configurations...
}
#The routing table for the public subnet, going through the internet gateway:#

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
}

resource "aws_route" "public" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.main.id
}

resource "aws_route_table_association" "public" {
  count          = length(var.public_subnets)
  subnet_id      = aws_subnet.public[count.index].id # Use indexing to get specific subnet ID
  route_table_id = aws_route_table.public.id
}

resource "aws_nat_gateway" "main" {
  count         = length(var.private_subnet_cidr)
  allocation_id = aws_eip.nat[count.index].id
  subnet_id     = aws_subnet.public[count.index % length(aws_subnet.public)].id
  # Other configuration...
}



resource "aws_eip" "nat" {
  count = length(var.private_subnet_cidr)

}
resource "aws_route_table" "private" {
  count  = length(var.private_subnet_cidr)
  vpc_id = aws_vpc.main.id
}

resource "aws_route" "private" {
  count                  = length(compact(var.private_subnet_cidr))
  route_table_id         = element(aws_route_table.private.*.id, count.index)
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = element(aws_nat_gateway.main.*.id, count.index)
}

resource "aws_route_table_association" "private" {
  count          = length(aws_subnet.private)
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private[count.index].id
}




## ==========================================
## Creating AWS private route table associate section
## ==========================================
resource "aws_route_table_association" "pa1" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.pr.id
  }
## ==========================================
## Creating AWS private route table associate section
## ==========================================
#resource "aws_route_table_association" "pa1" {
 # subnet_id      = aws_subnet.private_subnet.id
 # route_table_id = aws_route_table.pr.id


## ==================================
## Creating routing associate
## ==================================
resource "aws_subnet" "private_subnet" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "us-east-2a"
  # Other subnet attributes...
}

resource "aws_route_table" "pr" {
  vpc_id = aws_vpc.main.id
  # Other route table attributes...
}

#resource "aws_route_table_association" "pa1" {
 # subnet_id      = aws_subnet.private_subnet.id
 # route_table_id = aws_route_table.pr.id
  # Other attributes...


