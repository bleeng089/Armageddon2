resource "aws_eip" "nat" { #elastic IP
  domain = "vpc"

  tags = {
    Name = "nat-Japan"
  }
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id #.nat references aws_eip.nat object
  subnet_id     = aws_subnet.public-ap-northeast-1a.id 

  tags = {
    Name = "nat-Japan"
  }

  depends_on = [aws_internet_gateway.igw] # ensures terraform creates IGW before creating this resource(NGW). NGW depend on IGW
}
###################################################################################################################################
resource "aws_eip" "nat-Brazil" { #elastic IP
  provider = aws.sa-east-1
  domain = "vpc"
  tags = {
    Name = "nat-Brazil"
  }
}

resource "aws_nat_gateway" "nat-Brazil" {
  provider = aws.sa-east-1
  allocation_id = aws_eip.nat-Brazil.id #.nat references aws_eip.nat object
  subnet_id     = aws_subnet.public-sa-east-1a.id 

  tags = {
    Name = "nat-Brazil"
  }

  depends_on = [aws_internet_gateway.igw] # ensures terraform creates IGW before creating this resource(NGW). NGW depend on IGW
}