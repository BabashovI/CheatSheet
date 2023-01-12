provider "aws" {
  region = "eu-west-3"
  #   access_key = "my-access-key"
  #   secret_key = "my-secret-key"
}

resource "aws_instance" "web" {
  #   ami           = "ami-070976c8d8c5f661d"
  ami           = "ami-0b6eae48e887a3d1c"
  instance_type = "t2.micro"

  tags = {
    Name       = "Terraform Instance"
    Department = "Training"
    Owner      = "Andrew"
  }
}