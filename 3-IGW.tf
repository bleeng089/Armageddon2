resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.app1-Japan.id

  tags = {
    Name    = "app1_IGW-Japan"
    Service = "J-Tele-Doctor"
  }
}
######################################################################
resource "aws_internet_gateway" "igw-Brazil" {
  provider = aws.sa-east-1
  vpc_id = aws_vpc.app1-Brazil.id

  tags = {
    Name    = "app1_IGW-Brazil"
    Service = "J-Tele-Doctor"
  }
}