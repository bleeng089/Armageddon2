
resource "aws_security_group" "app1-sg1-servers-Japan" {
  name        = "app1-sg1-servers-Japan"
  description = "app1-sg1-servers-Japan"
  vpc_id      = aws_vpc.app1-Japan.id

  ingress {
    description = "MyHomePage-port443"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "Allow syslog traffic"
    from_port   = 514
    to_port     = 514
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "Allow syslog traffic (TCP)"
    from_port   = 514
    to_port     = 514
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" #any protocol
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "app1-sg1-servers-Japan"
    Service = "J-Tele-Doctor"
  }

}






resource "aws_security_group" "app1-sg-LB01-Japan" {
  name        = "app1-sg-LB01-Japan"
  description = "app1-sg-LB01-Japan"
  vpc_id      = aws_vpc.app1-Japan.id

  ingress {
    description = "MyHomePage"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
    ingress {
    description = "MyHomePage-port443"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "app1-sg2-LB1"
    Service = "J-Tele-Doctor"
  }

}
################################################################################################################################################################
resource "aws_security_group" "app1-sg1-servers-Brazil" {
  provider = aws.sa-east-1
  name        = "app1-sg1-servers-Brazil"
  description = "app1-sg1-servers-Brazil"
  vpc_id      = aws_vpc.app1-Brazil.id

  ingress {
    description = "MyHomePage"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "Allow syslog traffic"
    from_port   = 514
    to_port     = 514
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "Allow syslog traffic (TCP)"
    from_port   = 514
    to_port     = 514
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" #any protocol
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "app1-sg1-servers-Brazil"
    Service = "J-Tele-Doctor"
  }
}

resource "aws_security_group" "app1-sg1-LB01-Brazil" {
  provider = aws.sa-east-1
  name        = "app1-sg1-LB01-Brazil"
  description = "app1-sg1-LB01-Brazil"
  vpc_id      = aws_vpc.app1-Brazil.id

  ingress {
    description = "MyHomePage"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
    ingress {
    description = "MyHomePage-port443"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "app1-sg2-LB1"
    Service = "application1"
    Owner   = "Luke"
    Planet  = "Musafar"
  }

}
#########################################################################
resource "aws_security_group" "Japan-Enpoint-1" {
  name        = "Japan-Enpoint-1"
  description = "Japan-Enpoint-1"
  vpc_id      = aws_vpc.app1-Japan.id

  ingress {
    description = "ssh"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }



  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" #any protocol
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "Japan-Enpoint-1"
    Service = "EC2-Connect"
  }

}
resource "aws_security_group" "Japan-SSH-syslog" {
  name        = "Japan-SSH-syslog"
  description = "Japan-SSH-syslog"
  vpc_id      = aws_vpc.app1-Japan.id

  ingress {
    description = "ssh"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
 
  ingress {
    description = "Allow syslog traffic"
    from_port   = 514
    to_port     = 514
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "Allow syslog traffic (TCP)"
    from_port   = 514
    to_port     = 514
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
 egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" #any protocol
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "Japan-SSH-syslog"
  }

}






resource "aws_security_group" "Brazil-SSH-syslog" {
provider = aws.sa-east-1
name        = "Brazil-SSH-syslog"
  description = "Brazil-SSH-syslog"
  vpc_id      = aws_vpc.app1-Brazil.id

  ingress {
    description = "ssh"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "Allow syslog traffic"
    from_port   = 514
    to_port     = 514
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "Allow syslog traffic (TCP)"
    from_port   = 514
    to_port     = 514
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

 egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" #any protocol
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "Brazil-SSH-syslog"
  }

}