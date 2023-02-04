resource "aws_db_instance" "medx-rds" {
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "postgres"
  engine_version       = "10.18"
  instance_class       = "db.t2.micro"
  db_name              = "accounts"
  username             = "root"
  password             = "admin123vpro"
  parameter_group_name = "default.postgres10"
  multi_az             = "false"
  skip_final_snapshot  = true
  vpc_security_group_ids = [aws_security_group.medx-rds-sg.id]
  tags = {
    Name = "vpro-rds"
   }   
}
