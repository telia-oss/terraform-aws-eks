variable "cluster-name" {
  default     = "default-cluster"
  description = "Cluster name"
  type        = "string"
}

variable "desiered-nodes" {
  default     = 6
  type        = "string"
  description = "Desirered amount of nodes in the cluster auto scaling group"
}

variable "max-nodes" {
  default     = 10
  type        = "string"
  description = "Maximum amount of nodes in the cluster auto scaling group"
}

variable "min-nodes" {
  default     = 3
  type        = "string"
  description = "Minimum amount of nodes in the cluster auto scaling group"
}

variable "node-instance-type" {
  default     = "m5.large"
  type        = "string"
  description = "Type of EC2 instances to be used in the cluster"
}
