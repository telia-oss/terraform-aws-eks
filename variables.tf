variable "cluster-name" {
  type        = "string"
  description = "Cluster name"
}

variable "vpc-id" {
  type        = "string"
  description = "VPC ID"
}

// https://docs.aws.amazon.com/eks/latest/userguide/platform-versions.html
variable "kubernetes-version" {
  default     = ""                   // If empty, will use the newest
  description = "Kubernetes version"
}

variable "desiered-nodes" {
  type        = "string"
  description = "Desirered amount of nodes in the cluster auto scaling group"
}

variable "max-nodes" {
  type        = "string"
  description = "Maximum amount of nodes in the cluster auto scaling group"
}

variable "min-nodes" {
  type        = "string"
  description = "Minimum amount of nodes in the cluster auto scaling group"
}

variable "node-instance-type" {
  default     = "m5.large"
  type        = "string"
  description = "Type of EC2 instances to be used in the cluster"
}
