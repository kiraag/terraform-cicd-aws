provider "aws" {
  region = "ap-south-1"
  secret_key = ""
  access_key = ""
}

terraform {
  backend "s3" {
    encrypt = false
    bucket = "tf-state-s3"
    dynamodb_table = "tf-state-lock-dynamo"
    key = "path/path/terraform-tfstate"
    region = "ap-south-1"
  }
}

resource "aws_vpc" "tf_test" {
  cidr_block = "10.0.0.0/16"
  instance_tenancy = "default"
  enable_dns_hostnames = true
  tags = {
    Name = tf_test
  }
}

resource "aws_subnet" "public-subnet-1" {
  vpc_id = aws_vpc.tf_test.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "ap-south-1"
  tags = {
    Name = "public-subnet-1a"
  }
}

resource "aws_subnet" "private-subnet-1" {
  vpc_id = aws_vpc.tf_test.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "ap-south-1b"
  tags = {
    Name = "private-subnet-1"
  }
}