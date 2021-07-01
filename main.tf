provider "aws" {
    region = var.region
}


resource "aws_instance" "myec2"{
      ami           = "ami-0ab4d1e9cf9a1215a" # us-west-2
  instance_type = "t2.micro"

}
