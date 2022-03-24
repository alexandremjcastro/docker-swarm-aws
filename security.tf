resource "aws_security_group" "ec2" {
  name        = "sg_docker_swarm"
  description = "Allow SSH, HTTP, HTTPS inbound traffic"
  vpc_id      = aws_vpc.new-vpc.id
  ingress {
    description = "SSH"
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
  }
  ingress {
    description = "HTTP"
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
  }
  ingress {
    description = "HTTPS"
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
  }
  ingress {
    cidr_blocks     = [var.vpc_cidr_block]
    description     = "EC2toEC2"
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "sg_docker_swarm"
  }
}

resource "aws_security_group" "efs" {
  name        = "sg_docker_swarm_efs"
  description = "Allos inbound efs traffic from ec2"
  vpc_id      = aws_vpc.new-vpc.id
  ingress {
    security_groups = [aws_security_group.ec2.id]
    description     = "EC2toEFS"
    from_port       = 2049
    to_port         = 2049
    protocol        = "tcp"
  }
  ingress {
    cidr_blocks     = [var.vpc_cidr_block]
    description     = "EFStoEFS"
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
  }
  egress {
    security_groups = [aws_security_group.ec2.id]
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
  }
  tags = {
    Name = "sg_docker_swarm_efs"
  }
}