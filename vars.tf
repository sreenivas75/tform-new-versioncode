variable AWS_REGION {
	default = "eu-west-1"
}
variable AMIS {
	type = map
	default = {
	  eu-west-1 = "ami-02df9ea15c1778c9c"
	  us-west-1 = "ami-06397100adf427136"
	  ap-south-1 = "ami-009110a2bf8d7dd0a"

        }
}

variable ZONE1 {
        default = "eu-west-1a"

}

variable PRIV_KEY_PATH {
	default = "vprokey"
}

variable PUB_KEY_PATH {
        default = "vprokey.pub"
}
variable username {
	default = "ubuntu"
}
variable "instance_count"{
	default = "2"
}

