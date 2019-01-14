output "config_map_aws_auth" {
  value = <<CONFIGMAP


apiVersion: v1
kind: ConfigMap
metadata:
  name: aws-auth
  namespace: kube-system
data:
  mapRoles: |
    - rolearn: ${aws_iam_role.eks-worker.arn}
      username: system:node:{{EC2PrivateDNSName}}
      groups:
        - system:bootstrappers
        - system:nodes
CONFIGMAP
}

output "eks_platform_version" {
  value = "${aws_eks_cluster.eks-master.platform_version}"
}

output "eks_worker_iam_role_id" {
  value = "${aws_iam_role.eks-worker.id}"
}

output "eks_worker_iam_role_arn" {
  value = "${aws_iam_role.eks-worker.arn}"
}

output "eks_worker_security_group_id" {
  value = "${aws_security_group.eks-worker.id}"
}

output "eks_worker_security_group_arn" {
  value = "${aws_security_group.eks-worker.arn}"
}

output "eks_master_iam_role_id" {
  value = "${aws_iam_role.eks-master.id}"
}

output "eks_master_iam_role_arn" {
  value = "${aws_iam_role.eks-master.arn}"
}

output "eks_master_security_group_id" {
  value = "${aws_security_group.eks-master.id}"
}

output "eks_master_security_group_arn" {
  value = "${aws_security_group.eks-master.arn}"
}
