terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region  = var.region
  default_tags {
    tags = var.default_tags
  }
}

resource "aws_subnet" "private_subnets" {
  count             = length(var.private_subnet_cidrs)
  vpc_id            = data.aws_vpc.vpc.id
  cidr_block        = element(var.private_subnet_cidrs, count.index)
  availability_zone = element(var.availability_zones, count.index)

  tags = {
    Name = "Private Subnet ${count.index + 1} - ${data.aws_vpc.vpc.tags["Name"]}"
  }
}

resource "aws_route_table" "public_rt" {
  vpc_id = data.aws_vpc.vpc.id
  route {
    cidr_block = data.aws_vpc.vpc.cidr_block
    gateway_id = "local"
  }

  tags = {
    Name = "Private Route Table - ${data.aws_vpc.vpc.tags["Name"]}"
  }
}

resource "aws_route_table_association" "public" {
  count          = length(aws_subnet.private_subnets)
  subnet_id      = aws_subnet.private_subnets[count.index].id
  route_table_id = aws_route_table.public_rt.id
}