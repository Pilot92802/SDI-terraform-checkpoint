// Add a security group
resource "aws_security_group" "cjd-chkpt-sg" {
  name        = "cjd-chkpt-sg"
  description = "Allow tcp and http inbound traffic"
  
  ingress {
    description      = "ability to ssh connect"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    description      = "ability to http to web server"
    from_port        = 8080
    to_port          = 8080
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "cjd-chkpt-sg"
  }
}