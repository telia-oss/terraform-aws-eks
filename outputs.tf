output "config_map_aws_auth" {
  value = <<CONFIGMAP


apiVersion: v1
kind: ConfigMap
metadata:
  name: aws-auth
  namespace: kube-system
data:
  mapRoles: |
    - rolearn: ${aws_iam_role.eks-worker.arn != "" ? aws_iam_role.eks-worker.arn : ""}
      username: system:node:{{EC2PrivateDNSName}}
      groups:
        - system:bootstrappers
        - system:nodes
CONFIGMAP
}

output "kubeconfig" {
  value = <<KUBECONFIG


apiVersion: v1
clusters:
- cluster:
    server: ${aws_eks_cluster.eks-master.endpoint != "" ? aws_eks_cluster.eks-master.endpoint : ""}
    certificate-authority-data: ${aws_eks_cluster.eks-master.certificate_authority.0.data != "" ? aws_eks_cluster.eks-master.certificate_authority.0.data : ""}
  name: kubernetes
contexts:
- context:
    cluster: kubernetes
    user: aws
  name: aws
current-context: aws
kind: Config
preferences: {}
users:
- name: aws
  user:
    exec:
      apiVersion: client.authentication.k8s.io/v1alpha1
      command: aws-iam-authenticator
      args:
        - "token"
        - "-i"
        - "${var.cluster_name}"
KUBECONFIG
}

output "eks_worker_iam_role" {
  value = "${aws_iam_role.eks-worker.id}"
}

output "eks_worker_security_group" {
  value = "${aws_security_group.eks-worker.id}"
}

output "eks_master_iam_role" {
  value = "${aws_iam_role.eks-master.id}"
}

output "eks_master_security_group" {
  value = "${aws_security_group.eks-master.id}"
}
