provider "aws" {
  region  = "eu-west-1"
  version = ">= 2.10"
}

data "aws_availability_zones" "available" {
}

locals {
  cluster_name = "example-cluster"
}

resource "aws_vpc" "vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
  }
}

resource "aws_subnet" "public" {
  count = 3

  availability_zone = data.aws_availability_zones.available.names[count.index]
  cidr_block        = "10.0.${count.index}.0/24"
  vpc_id            = aws_vpc.vpc.id

  tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
  }
}

resource "aws_internet_gateway" "internet-gateway" {
  vpc_id = aws_vpc.vpc.id
}

resource "aws_route_table" "route-table" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet-gateway.id
  }
}

resource "aws_route_table_association" "route-table-association" {
  count = 3

  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.route-table.id
}

module "eks" {
  source       = "../.."
  vpc_id       = aws_vpc.vpc.id
  subnet_ids   = aws_subnet.public.*.id
  cluster_name = local.cluster_name

  nodes = [
    {
      desired_nodes = "1"
      max_nodes     = "1"
      min_nodes     = "1"
      instance_type = "m5.large"
    },
    {
      desired_nodes = "1"
      max_nodes     = "1"
      min_nodes     = "1"
      instance_type = "m5.xlarge"
    },
  ]
}

output "eks_platform_version" {
  value = module.eks.eks_platform_version
}

