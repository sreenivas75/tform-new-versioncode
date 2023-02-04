resource "aws_ebs_volume" "medx-vol-1" {
  availability_zone = "eu-west-1a"
  size              = 1
}
resource "aws_volume_attachment" "ebs_att_VOL-1" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.medx-vol-1.id
  instance_id = aws_instance.Medx-Node.0.id 
}


resource "aws_ebs_volume" "medx-vol-2" {
  availability_zone = "eu-west-1b"
  size              = 1
}
resource "aws_volume_attachment" "ebs_att_VOL-2" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.medx-vol-2.id
  instance_id = aws_instance.Medx-Node.1.id
}




