data "aws_ami" "latest-amazon-linux-image" {
    most_recent = true
    owners = ["amazon"]
    filter {
        name = "name"
        values = ["amzn2-ami-kernel-*-x86_64-gp2"]
    }
    filter {
        name = "virtualization-type"
        values = ["hvm"]
    }
}



resource "aws_instance" "myapp-server" {
    ami = data.aws_ami.latest-amazon-linux-image.id
    instance_type = "t3.micro"

    subnet_id = aws_subnet.private-ap-northeast-1a.id
    vpc_security_group_ids = [aws_security_group.Japan-SSH-syslog.id]
    user_data = base64encode(<<-EOF
#!/bin/bash
# Install and configure rsyslog
# Install rsyslog
yum install -y rsyslog

# Start and enable rsyslog
systemctl start rsyslog
systemctl enable rsyslog

# Configure rsyslog to accept remote logs
echo "
# Provides TCP syslog reception
module(load=\"imtcp\")
input(type=\"imtcp\" port=\"514\")

# Provides UDP syslog reception
module(load=\"imudp\")
input(type=\"imudp\" port=\"514\")
" >> /etc/rsyslog.conf

# Restart rsyslog to apply changes
systemctl restart rsyslog

 EOF
  )
user_data_replace_on_change = true
}

output "syslog_server_private_ip" {
  value       = aws_instance.myapp-server.private_ip
  description = "The private IP address of the syslog server"
}

