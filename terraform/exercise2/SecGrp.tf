resource "aws_security_group" "dove-sg" {
  name        = "dove-sg"
  description = "Allow TLS inbound traffic and all outbound traffic for dove-sg"
  # commented vpc_id to create default vpc
  #   vpc_id      = aws_vpc.main.id

  tags = {
    Name = "allow_tls"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allowSSHFromMyIp" {
  security_group_id = aws_security_group.dove-sg.id
  #   cidr_ipv4         = aws_vpc.main.cidr_block
  cidr_ipv4   = "136.158.35.221/32" #Allows for a specific single IP
  from_port   = 22
  ip_protocol = "tcp"
  to_port     = 22
}

resource "aws_vpc_security_group_ingress_rule" "allowWebAccessAnywhere" {
  security_group_id = aws_security_group.dove-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_dove-sg_ipv4" {
  security_group_id = aws_security_group.dove-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv6" {
  security_group_id = aws_security_group.dove-sg.id
  cidr_ipv6         = "::/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}   