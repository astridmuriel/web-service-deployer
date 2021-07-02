provider "aws" {
    region = var.region
}


/* Create VPC and Subnets from module */
module "networking"{
    source="modules/networking"
    cidr_block =var.cidr_block_vpc
    instance_tenancy = var.instance_tenancy
    enable_dns_hostnames = var.enable_dns_hostnames
    map_public_ip_on_launch = var.map_public_ip_on_launch

}
