# Create a VPC
resource "aws_vpc" "vpc"{
  cidr_block              = var.cidr_block
  instance_tenancy        = var.instance_tenancy
  enable_dns_hostnames    = var.enable_dns_hostnames

  tags      = {
    Name    = var.vpc_name
  }

}

#Create an IG 
resource "aws_internet_gateway" "ig" {
    vpc_id = aws_vpc.vpc.id
    tags ={
        Name=var.ig_name
    }
  
}

# Create a list of public subnets from a list
resource "aws_subnet" "public_subnet" {
    count = length(var.public_subnet_cidr_list)
    vpc_id = aws_vpc.vpc.id
    cidr_block=element(public_subnet_cidr_list, count.index)
    availability_zone = element(availability_zones_list, count.index)
   map_public_ip_on_launch = var.map_public_ip_on_launch
   tags ={
       Name = var.public_subnet_name-count.index
   }
}