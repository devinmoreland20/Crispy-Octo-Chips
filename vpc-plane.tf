resource "aws_vpc" "vpc1" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "vpc1"
  }
}

resource "aws_internet_gateway" "vpc1" {
  vpc_id = aws_vpc.vpc1.id

  tags = {
    Name = "vpc1"
  }
}

resource "aws_default_route_table" "vpc1_rt" {
  default_route_table_id = aws_vpc.vpc1.default_route_table_id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.vpc1.id
  }
  route {
    cidr_block         = "10.10.0.0/16"
    transit_gateway_id = aws_ec2_transit_gateway.transit_gateway.id
  }
  route {
    cidr_block         = "10.20.0.0/16"
    transit_gateway_id = aws_ec2_transit_gateway.transit_gateway.id
  }


  tags = {
    Name = "vpc1"
  }
}

resource "aws_route_table_association" "vpc1" {
  subnet_id      = aws_subnet.vpc1.id
  route_table_id = aws_default_route_table.vpc1_rt.id
}

resource "aws_subnet" "vpc1" {
  vpc_id            = aws_vpc.vpc1.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "vpc1"
  }
}


resource "aws_vpc" "vpc2" {
  cidr_block       = "10.10.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "vpc2"
  }
}

resource "aws_internet_gateway" "vpc2" {
  vpc_id = aws_vpc.vpc2.id

  tags = {
    Name = "vpc2"
  }
}
resource "aws_default_route_table" "vpc2_rt" {
  default_route_table_id = aws_vpc.vpc2.default_route_table_id

  route {
    cidr_block = "0.0.0.0/0"
    #gateway_id = aws_internet_gateway.vpc2.id
    nat_gateway_id = aws_nat_gateway.vpc2.id
  }

  route {
    cidr_block         = "10.0.0.0/16"
    transit_gateway_id = aws_ec2_transit_gateway.transit_gateway.id
  }
  route {
    cidr_block         = "10.20.0.0/16"
    transit_gateway_id = aws_ec2_transit_gateway.transit_gateway.id
  }

  tags = {
    Name = "vpc2"
  }
}

resource "aws_route_table_association" "vpc2" {
  subnet_id      = aws_subnet.vpc2.id
  route_table_id = aws_default_route_table.vpc2_rt.id
}

resource "aws_subnet" "vpc2" {
  vpc_id            = aws_vpc.vpc2.id
  cidr_block        = "10.10.1.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "vpc2"
  }
}


resource "aws_vpc" "vpc3" {
  cidr_block       = "10.20.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "vpc3"
  }
}

resource "aws_internet_gateway" "vpc3" {
  vpc_id = aws_vpc.vpc3.id

  tags = {
    Name = "vpc3"
  }
}
resource "aws_default_route_table" "vpc3_rt" {
  default_route_table_id = aws_vpc.vpc3.default_route_table_id

  route {
    cidr_block = "0.0.0.0/0"
    #gateway_id = aws_internet_gateway.vpc3.id
    nat_gateway_id = aws_nat_gateway.vpc3.id
  }
  route {
    cidr_block         = "10.0.0.0/16"
    transit_gateway_id = aws_ec2_transit_gateway.transit_gateway.id
  }
  route {
    cidr_block         = "10.10.0.0/16"
    transit_gateway_id = aws_ec2_transit_gateway.transit_gateway.id
  }

  tags = {
    Name = "vpc3"
  }
}


resource "aws_route_table_association" "vpc3" {
  subnet_id      = aws_subnet.vpc3.id
  route_table_id = aws_default_route_table.vpc3_rt.id
}


resource "aws_subnet" "vpc3" {
  vpc_id            = aws_vpc.vpc3.id
  cidr_block        = "10.20.1.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "vpc3"
  }
}



resource "aws_nat_gateway" "vpc1" {
  allocation_id = aws_eip.vpc1.id
  subnet_id     = aws_subnet.vpc1.id

  tags = {
    Name = "gw NAT"
  }

  depends_on = [aws_internet_gateway.vpc1]
}

resource "aws_eip" "vpc1" {
  vpc = true

  associate_with_private_ip = "10.0.0.12"
  depends_on                = [aws_internet_gateway.vpc1]
}

resource "aws_nat_gateway" "vpc2" {
  allocation_id = aws_eip.vpc2.id
  subnet_id     = aws_subnet.vpc2.id

  tags = {
    Name = "gw NAT"
  }

  depends_on = [aws_internet_gateway.vpc2]
}

resource "aws_eip" "vpc2" {
  vpc = true

  associate_with_private_ip = "10.0.0.13"
  depends_on                = [aws_internet_gateway.vpc2]
}


resource "aws_nat_gateway" "vpc3" {
  allocation_id = aws_eip.vpc3.id
  subnet_id     = aws_subnet.vpc3.id

  tags = {
    Name = "gw NAT"
  }

  depends_on = [aws_internet_gateway.vpc3]
}

resource "aws_eip" "vpc3" {
  vpc = true

  associate_with_private_ip = "10.0.0.14"
  depends_on                = [aws_internet_gateway.vpc3]
}



resource "aws_internet_gateway" "bastion" {
  vpc_id = aws_vpc.vpc1.id

  tags = {
    Name = "vpc1"
  }
}

resource "aws_subnet" "bastion" {
  vpc_id            = aws_vpc.vpc1.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "bastion"
  }
}

resource "aws_route_table" "bastion" {
  vpc_id = aws_vpc.vpc1.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.bastion.id
  }

  tags = {
    Name = "vpc1"
  }
}

resource "aws_route_table_association" "bastion" {
  subnet_id      = aws_subnet.bastion.id
  route_table_id = aws_route_table.bastion.id
}
