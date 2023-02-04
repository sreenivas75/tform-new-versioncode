resource "aws_vpc" "medx-test-vpc" {
	cidr_block = "10.0.0.0/16"
        instance_tenancy = "default"
	enable_dns_support = "true"
	enable_dns_hostnames = "true"
	tags = {
	  Name = "medx"
	}
}
resource "aws_subnet" "medx-pub-1" {
	vpc_id = aws_vpc.medx-test-vpc.id
	cidr_block = "10.0.1.0/24"
	map_public_ip_on_launch = "true"
	availability_zone = "eu-west-1a"
	tags = {
	  Name = "medx-prod-dmz-zone-a-subnet"
        }
}
resource "aws_subnet" "medx-pub-2" {
        vpc_id = aws_vpc.medx-test-vpc.id
        cidr_block = "10.0.2.0/24"
        map_public_ip_on_launch = "true"
        availability_zone = "eu-west-1b"
        tags = {
          Name = "medx-prod-dmz-zone-b-subnet"
        }
}
resource "aws_subnet" "medx-pub-3" {
        vpc_id = aws_vpc.medx-test-vpc.id
        cidr_block = "10.0.3.0/24"
        map_public_ip_on_launch = "true"
        availability_zone = "eu-west-1a"
        tags = {
          Name = "medx-prod-public-subnet"
        }
}

resource "aws_subnet" "medx-priv-1" {
        vpc_id = aws_vpc.medx-test-vpc.id
        cidr_block = "10.0.4.0/24"
        map_public_ip_on_launch = "true"
        availability_zone = "eu-west-1a"
        tags = {
          Name = "medx-prod-db-zone-a-subnet"
        }
}

resource "aws_subnet" "medx-priv-2" {
        vpc_id = aws_vpc.medx-test-vpc.id
        cidr_block = "10.0.5.0/24"
        map_public_ip_on_launch = "true"
        availability_zone = "eu-west-1b"
        tags = {
          Name = "medx-prod-db-zone-b-subnet"
        }
}
resource "aws_subnet" "medx-priv-3" {
        vpc_id = aws_vpc.medx-test-vpc.id
        cidr_block = "10.0.6.0/24"
        map_public_ip_on_launch = "true"
        availability_zone = "eu-west-1a"
        tags = {
          Name = "medx-prod-management-zone-a-subnet"
        }
}
resource "aws_subnet" "medx-priv-4" {
        vpc_id = aws_vpc.medx-test-vpc.id
        cidr_block = "10.0.7.0/24"
        map_public_ip_on_launch = "true"
        availability_zone = "eu-west-1b"
        tags = {
          Name = "medx-prod-management-zone-b-subnet"
        }
}


# Internet Gateway Setup

resource "aws_internet_gateway" "medx-IGW" {
  vpc_id = aws_vpc.medx-test-vpc.id

  tags = {
    Name = "medx-IGW"
  }
}

resource "aws_route_table" "medx-pub-RT" {
  vpc_id = aws_vpc.medx-test-vpc.id


  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.medx-IGW.id
  }
  tags = {
   Name = "medx-pub-RT"
   }
}
resource "aws_route_table_association" "medx-pub-1a" {
	subnet_id = aws_subnet.medx-pub-1.id
        route_table_id = aws_route_table.medx-pub-RT.id     

}

resource "aws_route_table_association" "medx-pub-2b" {
        subnet_id = aws_subnet.medx-pub-2.id
        route_table_id = aws_route_table.medx-pub-RT.id

}

resource "aws_route_table_association" "medx-pub-3a" {
        subnet_id = aws_subnet.medx-pub-3.id
        route_table_id = aws_route_table.medx-pub-RT.id

}
# NAT Gateway Setup

# Creating EIP

resource "aws_eip" "medx-eip" {
  vpc = true
}

resource "aws_nat_gateway" "medx-NGW" {
  allocation_id = aws_eip.medx-eip.id
  subnet_id = aws_subnet.medx-pub-3.id

  tags = {
    Name = "medx-NGW"
  }
}
resource "aws_route_table" "medx-priv-RT" {
  vpc_id = aws_vpc.medx-test-vpc.id

  route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.medx-NGW.id
    }
tags = {
        Name = "medx-priv-RT"
    }
}
resource "aws_route_table_association" "medx-priv-1a" {
        subnet_id = aws_subnet.medx-priv-1.id
        route_table_id = aws_route_table.medx-priv-RT.id

}

resource "aws_route_table_association" "medx-priv-2b" {
        subnet_id = aws_subnet.medx-priv-2.id
        route_table_id = aws_route_table.medx-priv-RT.id

}

resource "aws_route_table_association" "medx-priv-3a" {
        subnet_id = aws_subnet.medx-priv-3.id
        route_table_id = aws_route_table.medx-priv-RT.id

}
resource "aws_route_table_association" "medx-priv-4b" {
        subnet_id = aws_subnet.medx-priv-3.id
        route_table_id = aws_route_table.medx-priv-RT.id

}

