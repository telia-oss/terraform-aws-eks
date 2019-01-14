variable "cluster_name" {
  type        = "string"
  description = "Cluster name"
}

variable "vpc_id" {
  type        = "string"
  description = "VPC ID"
}

variable "subnet_ids" {
  type = "list"
}

// https://docs.aws.amazon.com/eks/latest/userguide/platform-versions.html
variable "kubernetes_version" {
  default     = ""                   // If empty, will use the newest
  description = "Kubernetes version"
}

variable "desired_nodes" {
  type        = "string"
  description = "Desired number of worker nodes in the cluster auto scaling group"
}

variable "max_nodes" {
  type        = "string"
  description = "Maximum number of worker nodes in the cluster auto scaling group"
}

variable "min_nodes" {
  type        = "string"
  description = "Minimum number of worker nodes in the cluster auto scaling group"
}

variable "node_instance_type" {
  default     = "m5.large"
  type        = "string"
  description = "Type of EC2 instances to be used in the cluster"
}
