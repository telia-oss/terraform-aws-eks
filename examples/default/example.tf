provider "aws" {
  region = "eu-west-1"
}

module "eks" {
  source             = "../.."
  cluster-name       = "default-cluster"
  desiered-nodes     = "3"
  max-nodes          = "6"
  min-nodes          = "1"
  node-instance-type = "m5.large"
}
