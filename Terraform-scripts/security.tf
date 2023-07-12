# Create a security group
resource "aws_security_group" "vprofile-app-sg" {
  name        = var.security_group_name
  description = var.security_group_description
  vpc_id      = aws_vpc.vprofile-app.id

  # Inbound rules
  ingress {
    from_port   = var.allowed_inbound_ports[0]
    to_port     = var.allowed_inbound_ports[0]
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = var.allowed_inbound_ports[1]
    to_port     = var.allowed_inbound_ports[1]
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = var.allowed_inbound_ports[2]
    to_port     = var.allowed_inbound_ports[2]
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Outbound rules
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}