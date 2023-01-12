// aws ec2 create-default-subnet --availability-zone zone-number
provider "aws" {
  //access_key = ''
  //secret_key = ''
  //region = "eu-west-1"
}

# data "aws_availability_zones" "available" {
#   state = "available"
# }
# output "zones" {
#   value = data.aws_availability_zones.available
# }
# resource "aws_default_vpc" "default" {
#   tags = {
#     Name = "Default VPC"
#   }
# }

resource "aws_instance" "web" {
  //count = [for k, v in var.instance_count : k] == "two" ? var.instance_count["two"] : var.instance_count["four"]
  //for_each = var.instance_count.type
  ami           = "ami-0caef02b518350c8b"
  instance_type = "t2.micro"

  # dynamic "tags" {
  #   for_each = var.instance_count
  #   content {
  #     Name = tags.value
  #     # Course = "TF live session"
  #     # Owner  = "IbrahimB"
  #   }
  # }
}
locals {
  for_each = var.instance_count
}
# output "var_out" {

#   //for_each = var.instance_count
#   //value = [for k, v in var.instance_count : v]
# }
