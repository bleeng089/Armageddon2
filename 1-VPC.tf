# this  makes  vpc.id which is aws_vpc.app1.id
resource "aws_vpc" "app1-Japan" {
  cidr_block = "10.150.0.0/16"

  tags = {
    Name = "app1"
    Service = "J-Tele-Doctor"
  }
}
####################################################################################
resource "aws_vpc" "app1-Brazil" {
  provider = aws.sa-east-1
  cidr_block = "10.153.0.0/16"

  tags = {
    Name = "app2"
    Service = "J-Tele-Doctor"
  }
}