resource "aws_key_pair" "vprokey" {
   key_name = "vprokey"
   public_key = file(var.PUB_KEY_PATH)
}

resource "aws_instance" "Medx-Node" {
   ami = lookup(var.AMIS, var.AWS_REGION)
   instance_type = "t2.micro"
   key_name = aws_key_pair.vprokey.key_name
   security_groups = [aws_security_group.Medx-Instance-sg.name]
   count =var.instance_count
  
   tags = {
     Name = "Medx-Node${count.index+1}"
     Project = "dermsecure"
}
#provisioner "file" {
 #  content = templatefile("templates/application.tmpl", {rds-endpoint= aws_db_instance.vpro-rds.address})
  # destination = "tmp/application.properties"
#   }  

#provisioner "file" {
 #   content = templatefile("templates/web-deploy.tmpl", {rds-endpoint = aws_db_instance.vpro-rds.endpoint})

#    destination = "/tmp/vpro-app.sh"

#}

#provisioner "remote-exec" {
 #  inline = [
  #   "chmod +x /tmp/vpro-app.sh",
   #  "sudo /tmp/vpro-app.sh"
        # ]

# }
connection {
   user = var.username
   private_key = file(var.PRIV_KEY_PATH)
   host = self.private_ip
   }
}

output "app01-IP" {
   value = aws_instance.Medx-Node.0.private_ip
  }
output "app02-IP" {
 value = aws_instance.Medx-Node.1.private_ip
  }

