provider "aws" {
    region = var.region
}


resource "aws_instance"{
      ami           = "ami-0d296d66f22f256c2" # us-west-2
  instance_type = "t2.micro"

}