data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "vpc1" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.vpc1.id
  key_name                    = "Mac"
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.ssh1.id]

  tags = {
    Name = "vpc1"
  }
}

resource "aws_instance" "vpc2" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.vpc2.id
  key_name                    = "Mac"
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.ssh2.id]

  tags = {
    Name = "vpc2"
  }
}

resource "aws_instance" "vpc3" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.vpc3.id
  key_name                    = "Mac"
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.ssh3.id]

  tags = {
    Name = "vpc3"
  }
}


resource "aws_instance" "bastion" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.bastion.id
  key_name                    = "Mac"
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.bastion.id]

  tags = {
    Name = "bastion"
  }
}
