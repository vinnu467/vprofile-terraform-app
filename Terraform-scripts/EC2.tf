# Create EC2 instances for QA, Stage, and Production
resource "aws_instance" "qa_instance" {
  count         = 1
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = aws_subnet.public_subnet[0].id
  security_groups = [aws_security_group.vprofile-app-sg.id]
  tags = {
    Name = "QA"
  }
}

resource "aws_instance" "stage_instance" {
  count         = 1
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     =aws_subnet.public_subnet[1].id
  security_groups = [aws_security_group.vprofile-app-sg.id]
  tags = {
    Name = "Stage"
  }
}

resource "aws_instance" "production_instance" {
  count         = 1
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = aws_subnet.public_subnet[2].id
  security_groups = [aws_security_group.vprofile-app-sg.id]

  tags = {
    Name = "Production"
  }
}