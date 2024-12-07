resource "aws_ec2_transit_gateway" "Japan-TGW1" {
  provider = aws
  tags = {
    Name: "Japan-TGW1"
  }
}

resource "aws_ec2_transit_gateway" "Brazil-TGW1" {
  provider = aws.sa-east-1
  tags = {
    Name: "Brazil-TGW1"
  }
}


resource "aws_ec2_transit_gateway_vpc_attachment" "Private-VPC-Japan-TG-attach" {
  subnet_ids         = [aws_subnet.private-ap-northeast-1a.id, aws_subnet.private-ap-northeast-1c.id]
  transit_gateway_id = aws_ec2_transit_gateway.Japan-TGW1.id
  vpc_id             = aws_vpc.app1-Japan.id
  transit_gateway_default_route_table_association = false #or  by default associate to default Japan-TGW-Route-table
  transit_gateway_default_route_table_propagation = false #or  by default propagate to default Japan-TGW-Route-table
}

resource "aws_ec2_transit_gateway_vpc_attachment" "Private-VPC-Brazil-TG-attach" {
  provider = aws.sa-east-1
  subnet_ids         = [aws_subnet.private-sa-east-1a.id, aws_subnet.private-sa-east-1b.id]
  transit_gateway_id = aws_ec2_transit_gateway.Brazil-TGW1.id
  vpc_id             = aws_vpc.app1-Brazil.id
  transit_gateway_default_route_table_association = false
  transit_gateway_default_route_table_propagation = false
}



resource "aws_ec2_transit_gateway_peering_attachment" "Japan_Brazil_Peer" { #peer
  transit_gateway_id        = aws_ec2_transit_gateway.Japan-TGW1.id
  peer_transit_gateway_id   = aws_ec2_transit_gateway.Brazil-TGW1.id
  peer_region               = "sa-east-1"
  tags = {
    Name = "Japan-Brazil-Peer"
  }
}
resource "aws_ec2_transit_gateway_peering_attachment_accepter" "Brazil_Japan_Peer_Accepter" { #accept peer
  provider = aws.sa-east-1
  transit_gateway_attachment_id = aws_ec2_transit_gateway_peering_attachment.Japan_Brazil_Peer.id
  tags = {
    Name = "Brazil-Japan-Peer-Accepter"
  }
}


resource "aws_ec2_transit_gateway_route_table" "Brazil-TG-Route-Table" { #TGW route table Brazil 
  provider = aws.sa-east-1 
  transit_gateway_id = aws_ec2_transit_gateway.Brazil-TGW1.id 
} 
resource "aws_ec2_transit_gateway_route_table" "Japan-TG-Route-Table" { #TGW route table Japan 
  transit_gateway_id = aws_ec2_transit_gateway.Japan-TGW1.id 
}

resource "aws_ec2_transit_gateway_route_table_association" "Japan-TGW1_Association" { #Associates Japan-VPC-TGW-attach to Japan-TGW-Route-Table
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.Private-VPC-Japan-TG-attach.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.Japan-TG-Route-Table.id
}

resource "aws_ec2_transit_gateway_route_table_association" "Brazil-TGW1_Association" { #Attaches Brazil-VPC-TGW-attach to Brazil-TGW-Route-Table
  provider                       = aws.sa-east-1
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.Private-VPC-Brazil-TG-attach.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.Brazil-TG-Route-Table.id
}
resource "aws_ec2_transit_gateway_route_table_propagation" "Japan-TGW1_Propagation" { #Propagates US-VPC-TGW-attach to Japan-TGW-Route-Table
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.Private-VPC-Japan-TG-attach.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.Japan-TG-Route-Table.id
}

resource "aws_ec2_transit_gateway_route_table_propagation" "Brazil-TGW1_Propagation" { #Propagates Brazil-VPC-TGW-attach to Brazil-TGW-Route-Table
  provider                       = aws.sa-east-1
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.Private-VPC-Brazil-TG-attach.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.Brazil-TG-Route-Table.id
}

resource "aws_ec2_transit_gateway_route_table_association" "Japan-TGW1_Peer_Association" { #Associates Japan-Brazil-TGW-Peer to Japan-TGW-Route-Table
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_peering_attachment.Japan_Brazil_Peer.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.Japan-TG-Route-Table.id
  replace_existing_association = true #removes default TGW-Route-Table-Association so you can Associate with the one specified in your code
}

resource "aws_ec2_transit_gateway_route_table_association" "Brazil-TGW1_Peer_Association" { #Attaches Brazil-Japan-TGW-Peer to Brazil-TGW-Route-Table
  provider                       = aws.sa-east-1
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_peering_attachment.Japan_Brazil_Peer.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.Brazil-TG-Route-Table.id
  replace_existing_association = true
}


resource "aws_ec2_transit_gateway_route" "Japan_to_Brazil_Route" { #Route on TG Japan -> to -> Brazil
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.Japan-TG-Route-Table.id
  destination_cidr_block         = "10.153.0.0/16"  # CIDR block of the VPC in sa-east-1
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_peering_attachment.Japan_Brazil_Peer.id
}

resource "aws_ec2_transit_gateway_route" "Brazil_to_Japan_Route" { #Route on TG Brazil -> to ->US
  provider = aws.sa-east-1
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.Brazil-TG-Route-Table.id
  destination_cidr_block         = "10.150.0.0/16"  # CIDR block of the VPC in ap-northeast-1
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_peering_attachment.Japan_Brazil_Peer.id
}
