# Load Balancer
resource "aws_lb" "production_lb" {
  name               = "production-lb"
  subnets            = [aws_subnet.public_subnet[2].id, aws_subnet.public_subnet[0].id]  
  security_groups    = [aws_security_group.vprofile-app-sg.id]
  internal           = false
}

resource "aws_lb_target_group" "production_tg" {
  name     = "production-tg"
  port     = 8080
  protocol = "HTTP"
  vpc_id      = aws_vpc.vprofile-app.id
  target_type = "instance"
  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    interval            = 30
    path                = "/"
  }
}
resource "aws_lb_listener" "production_listener" {
  load_balancer_arn = aws_lb.production_lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.production_tg.arn
  }
}


# Launch Template
resource "aws_launch_template" "production_lt" {
  name                     = "production-lt"
  image_id                 = var.ami_id
  instance_type            = var.instance_type
  vpc_security_group_ids   = [aws_security_group.vprofile-app-sg.id]
  user_data                = ""
  block_device_mappings {
    device_name = "/dev/xvda"
    ebs {
      volume_size = 100
      volume_type = "gp2"
    }
  }
}

# Auto Scaling Group
resource "aws_autoscaling_group" "production_asg" {
  name                      = "production-asg"
  min_size                  = 1
  max_size                  = 3
  desired_capacity          = 1
  launch_template {
    id = aws_launch_template.production_lt.id
    version = "$Latest"
  }
  vpc_zone_identifier = [aws_subnet.public_subnet[2].id,aws_subnet.public_subnet[0].id]
  target_group_arns         = [aws_lb_target_group.production_tg.arn]
  health_check_type         = "ELB"
  health_check_grace_period = 300
  tags = [
    {
      key                 = "Name"
      value               = "Production"
      propagate_at_launch = true
    },
    {
      key                 = "Environment"
      value               = "Production"
      propagate_at_launch = true
    }
  ]
}
