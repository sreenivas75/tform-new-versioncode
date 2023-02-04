resource "aws_elb" "Medx-Node" {
  name               = "Medx-Node-elb"
  availability_zones = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
  security_groups    = [aws_security_group.medx-elb-sg.id]

  listener {
    instance_port     = 8080
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:8000/login"
    interval            = 30
  }

  instances                   = [aws_instance.Medx-Node.1.id,aws_instance.Medx-Node.0.id]
  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400

  tags = {
    Name = "Medx-Node-elb"
  }
}

