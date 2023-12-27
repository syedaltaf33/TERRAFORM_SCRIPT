provider "aws" {
    region = "ap-south-1"
}

resource "aws_vpc" "development" {
  cidr_block = var.vpc_ip_range[0].ci_dr_block
  tags = {
    Name: var.vpc_ip_range[0].name,
    vpc_env: "dev"
  }
}
variable "Environment" {
  description = "this is vpc tags"
  default = "dev"
}


variable "vpc_ip_range" {
  description = "this is vpc cidr blocks"
  type = list(object({
     ci_dr_block = string
     name = string
 }))

}


resource "aws_subnet" "dev-subnet1" {
  vpc_id = aws_vpc.development.id
  cidr_block = var.vpc_ip_range[1].ci_dr_block
  availability_zone = "ap-south-1a"
  tags = {
    Name: var.vpc_ip_range[1].name
  }
  
}

data "aws_vpc" "exsting_vpc" {
  default = true
}

resource "aws_subnet" "dev-subnet2" {
  vpc_id = data.aws_vpc.exsting_vpc.id
  cidr_block = "172.31.48.0/20"
  availability_zone = "ap-south-1a"
  tags = {
    Name: "dev-subnet2-default"
  }
  
}
 
output "ip" {
  value = aws_subnet.dev-subnet2.id 
} 