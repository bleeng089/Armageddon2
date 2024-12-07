
data "aws_ami" "latest-amazon-linux-image2" {
  provider    = aws.sa-east-1
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-*-x86_64-gp2"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}



resource "aws_instance" "myapp-agent" {
    provider = aws.sa-east-1
    ami = data.aws_ami.latest-amazon-linux-image2.id
    instance_type = "t3.micro"

    subnet_id = aws_subnet.private-sa-east-1a.id
    vpc_security_group_ids = [aws_security_group.Brazil-SSH-syslog.id]

    key_name = "MyLinuxBox3"
    user_data = base64encode(<<-EOF
#!/bin/bash
# Install rsyslog
yum install -y rsyslog

# Start and enable rsyslog
systemctl start rsyslog
systemctl enable rsyslog

# Configure rsyslog to forward logs to the syslog server
echo "
*.* @@10.150.11.67:514
" >> /etc/rsyslog.conf

# Restart rsyslog to apply changes
systemctl restart rsyslog
 EOF
  )
user_data_replace_on_change = true
}

output "syslog_agent_private_ip" {
  value       = aws_instance.myapp-agent.private_ip
  description = "The private IP address of the syslog agent"
}
