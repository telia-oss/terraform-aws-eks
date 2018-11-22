provider "aws" {
  region = "eu-west-1"
}

locals {
  cluster_name = "example-cluster"
}

resource "aws_vpc" "eks_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = "${
    map(
     "kubernetes.io/cluster/${local.cluster_name}", "shared",
    )
  }"
}

module "eks" {
  source             = "../.."
  vpc_id             = "${aws_vpc.eks_vpc.id}"
  cluster_name       = "${local.cluster_name}"
  desiered_nodes     = "3"
  max_nodes          = "6"
  min_nodes          = "1"
  node_instance_type = "m5.large"
}

output "kubeconfig" {
  value = "${module.eks.kubeconfig}"
}

output "config-map-aws-auth" {
  value = "${module.eks.config_map_aws_auth}"
}
