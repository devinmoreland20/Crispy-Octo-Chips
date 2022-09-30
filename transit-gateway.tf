resource "aws_ec2_transit_gateway" "transit_gateway" {
  description                     = "transit_gateway"
  default_route_table_association = "disable"
  default_route_table_propagation = "disable"
  tags = {
    "Name" = "TransitGateway"
  }
}




resource "aws_ec2_transit_gateway_vpc_attachment" "vpc1" {
  subnet_ids         = [aws_subnet.vpc1.id]
  transit_gateway_id = aws_ec2_transit_gateway.transit_gateway.id
  vpc_id             = aws_vpc.vpc1.id
}

resource "aws_ec2_transit_gateway_vpc_attachment" "vpc2" {
  subnet_ids         = [aws_subnet.vpc2.id]
  transit_gateway_id = aws_ec2_transit_gateway.transit_gateway.id
  vpc_id             = aws_vpc.vpc2.id
}

resource "aws_ec2_transit_gateway_vpc_attachment" "vpc3" {
  subnet_ids         = [aws_subnet.vpc3.id]
  transit_gateway_id = aws_ec2_transit_gateway.transit_gateway.id
  vpc_id             = aws_vpc.vpc3.id
}



resource "aws_ec2_transit_gateway_route_table" "tgrt_1" {
  transit_gateway_id = aws_ec2_transit_gateway.transit_gateway.id

  tags = {
    Name = "TransitGateway"
  }
}

resource "aws_ec2_transit_gateway_route" "vpc1" {
  destination_cidr_block         = "10.0.0.0/16"
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.vpc1.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.tgrt_1.id


}

resource "aws_ec2_transit_gateway_route" "vpc2" {
  destination_cidr_block         = "10.10.0.0/16"
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.vpc2.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.tgrt_1.id

}

resource "aws_ec2_transit_gateway_route" "vpc3" {
  destination_cidr_block         = "10.20.0.0/16"
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.vpc3.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.tgrt_1.id

}








resource "aws_ec2_transit_gateway_route_table_association" "vpc1" {
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.vpc1.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.tgrt_1.id
}

resource "aws_ec2_transit_gateway_route_table_association" "vpc2" {
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.vpc2.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.tgrt_1.id
}

resource "aws_ec2_transit_gateway_route_table_association" "vpc3" {
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.vpc3.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.tgrt_1.id
}








resource "aws_ec2_transit_gateway_route_table_propagation" "vpc1" {
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.vpc1.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.tgrt_1.id
}

resource "aws_ec2_transit_gateway_route_table_propagation" "vpc2" {
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.vpc2.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.tgrt_1.id
}

resource "aws_ec2_transit_gateway_route_table_propagation" "vpc3" {
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.vpc3.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.tgrt_1.id
}

