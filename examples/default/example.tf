provider "aws" {
  region = "eu-west-1"
}

variable "cluster-name" {
  default = "example-cluster"
}

resource "aws_vpc" "eks-vpc" {
  cidr_block = "10.0.0.0/16"

  tags = "${
    map(
     "kubernetes.io/cluster/${var.cluster-name}", "shared",
    )
  }"
}

module "eks" {
  source             = "../.."
  vpc-id             = "${aws_vpc.eks-vpc.id}"
  cluster-name       = "${var.cluster-name}"
  desiered-nodes     = "3"
  max-nodes          = "6"
  min-nodes          = "1"
  node-instance-type = "m5.large"
}

output "kubeconfig" {
  value = "${module.eks.kubeconfig}"
}

output "config-map-aws-auth" {
  value = "${module.eks.config-map-aws-auth}"
}
