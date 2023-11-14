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

module "internet_gateway" {
  source = "../../internet-gateway"
  region = var.region
  default_tags = var.default_tags
  vpc_id  = var.vpc_id
}

resource "aws_subnet" "public_subnets" {
  count             = length(var.public_subnet_cidrs)
  vpc_id            = var.vpc_id
  cidr_block        = element(var.public_subnet_cidrs, count.index)
  availability_zone = element(var.availability_zones, count.index)
  tags = {
    Name = "Public Subnet ${count.index + 1} - ${data.aws_vpc.vpc.tags["Name"]}"
  }
}

resource "aws_route_table" "public_rt" {
  vpc_id = data.aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = module.internet_gateway.igw_id
  }

  tags = {
    Name = "Public Route Table - ${data.aws_vpc.vpc.tags["Name"]}"
  }
}

resource "aws_route_table_association" "public" {
  count          = length(aws_subnet.public_subnets)
  subnet_id      = aws_subnet.public_subnets[count.index].id
  route_table_id = aws_route_table.public_rt.id
}