resource "aws_instance" "web" {
  ami           = data.aws_ami.amiID.id
  instance_type = "t2.micro"
  #added attributes
  key_name               = aws_key_pair.dove_key.key_name
  vpc_security_group_ids = [aws_security_group.dove-sg.id]
  #1a is the availability zone
  availability_zone = "us-east-1a"

  tags = {
    Name    = "Dove-web"
    Project = "Dove"
  }
}

resource "aws_instance_state" "web_state" {
  instance_id = aws_instance.web.id
  state       = "running"
}