resource "aws_vpc" "msaicharan" {
  cidr_block = "17.2.0.0/16"
  tags = {
    Name = "msaicharan_vpc"
  }
}

resource "aws_subnet" "msaicharan_public_subnet" {
  vpc_id     = aws_vpc.msaicharan.id
  cidr_block = "17.2.1.0/24"
  tags = {
    Name = "msaicharan_public_subnet"
  }
}
resource "aws_subnet" "msaicharan_private_subnet" {
  vpc_id     = aws_vpc.msaicharan.id
  cidr_block = "17.2.2.0/24"
  tags = {
    Name = "msaicharan_private_subnet"
  }
}

resource "aws_internet_gateway" "msaicharan_igw" {
    vpc_id = aws_vpc.msaicharan.id
    tags = {
        Name = "msaicharan_igw"
    }
  
}

resource "aws_route_table" "msaicharan_routetable_public" {
    vpc_id = aws_vpc.msaicharan.id
route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.msaicharan_igw.id
    }
tags = {
        Name = "msaicharan_routetable_public"
    }
}
resource "aws_route_table_association" "msaicharan_public-rt_attach" {
    subnet_id = aws_subnet.msaicharan_public_subnet.id
    route_table_id = aws_route_table.msaicharan_routetable_public.id
}

resource "aws_route_table" "msaicharan_routetable_private" {
    vpc_id = aws_vpc.msaicharan.id
tags = {
        Name = "msaicharan_routetable_public"
    }
}
resource "aws_route_table_association" "rt_associate_private_2" {
    subnet_id = aws_subnet.msaicharan_private_subnet.id
    route_table_id = aws_route_table.msaicharan_routetable_private.id
}
