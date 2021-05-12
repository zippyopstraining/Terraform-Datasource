provider "aws" {
  region     = "us-east-1"
  access_key = "YOUR-ACCESS-KEY"
  secret_key = "YOUR-SECRET-KEY"
}

data "aws_vpc" "test" {
  filter {
     name = "tag:Name"
     values = ["test-vpc"]
  }
}

resource "aws_subnet" "main" {
  vpc_id = data.aws_vpc.test.id
  cidr_block = "10.8.0.0/16"
}

resource "aws_instance" "web" {
  ami = "ami-042e8287309f5df03"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.main.id

  tags = {
    name = "data-test"
 }
}
