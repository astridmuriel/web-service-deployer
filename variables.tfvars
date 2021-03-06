# region               = "us-east-1"
# azs_list             = ["us-east-1a", "us-east-1b"]
# private_subnets_list = ["10.0.1.0/24", "10.0.2.0/24"]
# public_subnets_list  = ["10.0.101.0/24", "10.0.102.0/24"]
# enable_nat_gateway   = true
# cluster_name         = "webserver"
# enable_vpn_gateway   = true
# cidr                 = "10.0.0.0/16"
# env                  = "dev"
# vpc_name             = "my-vpc"
# elb_port             = 80
# server_port          = 8080
# everywhere_cidr      = ["0.0.0.0/0"]
# image_id="ami-0ab4d1e9cf9a1215a"
# instance_type="t2.micro"


region="us-east-1"
cluster_name="web-service-deployer"
ami= "ami-0ab4d1e9cf9a1215a"
server_text= "HEllo there"
instance_type="t2.micro"
min_size=2
max_size=4
enable_autoscaling = true
db_remote_state_bucket="terraform-bucket-astrid"
