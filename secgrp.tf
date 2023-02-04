resource "aws_security_group" "medx-elb-sg" {
  name = "medx-elb-sg"
  description = "medx-elb-sg"
  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    }

   ingress {
     from_port = 80
     to_port   = 80
     protocol = "tcp"
     cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_security_group" "Medx-Instance-sg" {
   name = "Medx-Instance-sg"
   description = "Medx-Instance-sg"
   egress {
     from_port = 0
      to_port = 0
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]

       }   
       

   ingress {
       from_port = 22
       to_port = 22
       protocol = "tcp"
       cidr_blocks = ["35.182.247.4/32"]

     }


     ingress {
       from_port = 8080
       to_port = 8080
       protocol = "tcp"
       security_groups = [aws_security_group.medx-elb-sg.id]
      }
      
       ingress  {
        from_port = 8080
        to_port   = 8080
        protocol = "tcp"
        cidr_blocks = ["72.139.54.101/32"]
       }   

      ingress  {
        from_port = 22
        to_port   = 22
        protocol = "tcp"
        cidr_blocks = ["72.139.54.101/32"]
       }

}

resource "aws_security_group" "medx-rds-sg" {
  name = "medx-rds-sg"
  description = "medx-rds-sg"
  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    }

   ingress {
     from_port = 5656
     to_port   = 5656
     protocol = "tcp"
     security_groups = [aws_security_group.Medx-Instance-sg.id]
    }
}
