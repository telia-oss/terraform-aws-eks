### VPC Networking

data "aws_availability_zones" "available" {}

resource "aws_subnet" "eks-subnet" {
  count = 3

  availability_zone = "${data.aws_availability_zones.available.names[count.index]}"
  cidr_block        = "10.0.${count.index}.0/24"
  vpc_id            = "${var.vpc_id}"

  tags = "${
    map(
     "Name", "eks-${var.cluster_name}",
     "kubernetes.io/cluster/${var.cluster_name}", "shared",
    )
  }"
}

resource "aws_internet_gateway" "eks-internet-gateway" {
  vpc_id = "${var.vpc_id}"

  tags {
    Name = "eks-${var.cluster_name}"
  }
}

resource "aws_route_table" "eks-route-table" {
  vpc_id = "${var.vpc_id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.eks-internet-gateway.id}"
  }

  tags {
    Name = "eks-${var.cluster_name}"
  }
}

resource "aws_route_table_association" "eks-route-table-association" {
  count = 3

  subnet_id      = "${aws_subnet.eks-subnet.*.id[count.index]}"
  route_table_id = "${aws_route_table.eks-route-table.id}"
}
