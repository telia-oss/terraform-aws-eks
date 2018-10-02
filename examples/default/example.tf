provider "aws" {
  region = "eu-west-1"
}

module "eks" {
  source             = "../.."
  cluster-name       = "example-cluster"
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
