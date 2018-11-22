# AWS EKS Terraform Module

[![Build Status](https://travis-ci.com/telia-oss/terraform-aws-eks.svg?branch=master)](https://travis-ci.com/telia-oss/terraform-aws-eks) ![](https://img.shields.io/maintenance/yes/2018.svg)

Terraform module which creates a EKS cluster on AWS.

## Usage

### Prerequisite

* [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/)
* [aws-iam-authenticator](https://github.com/kubernetes-sigs/aws-iam-authenticator)

### Setup

1. Apply terraform config - create cluster (usually slow, i.e. 10+ mins.)
    * [Example config](examples/default/example.tf)

2. Save `kubeconfig` output from terraform somewhere (default kubeconfig location: `~/.kube/config`).

    ```sh
    terraform output kubeconfig
    ```
    Custom locations for kubeconfig files can be set by setting the `KUBECONFIG` env var:
    ```sh
    export KUBECONFIG=~./custom/location
    kubectl get nodes # works
    ```

    You can also use the [aws cli](https://docs.aws.amazon.com/cli/latest/reference/eks/update-kubeconfig.html):
    ```sh
    aws eks update-kubeconfig --name <cluster-name>
    ```

3. Confirm connection towards the cluster:

    ```sh
    kubectl get nodes # should return `no resources`
    ```

    ### Note

    When you create an Amazon EKS cluster, the IAM entity user or role (for example, for federated users) that creates the cluster is automatically granted system:master permissions in the cluster's RBAC configuration. 

    I.e if your cluster is created by a machine user role (e.g. as a part of a CI/CD task), you will need to assume this role to establish initial connection towards the cluster.

    More info [here](https://docs.aws.amazon.com/eks/latest/userguide/add-user-role.html).

4. Save and apply `config-map-aws-auth` output from terraform:

    ```sh
    terraform output config_map_aws_auth # save as auth-config.yml
    kubectl apply -f auth-config.yml
    ```

5. Confirm that nodes have joined/are joining the cluster

    ```sh
    kubectl get nodes # should show a list of nodes
    ```

### Note

* Cluster access requires an authenticated shell towards AWS in addition to the kubeconfig being present.
  * E.g: make sure that [`vaulted`](https://github.com/miquella/vaulted):
    * is working
    * session hasn't timed out
    * the correct AWS role is in use

## Examples

Terraform module which creates a EKS cluster on AWS.

## Authors

Currently maintained by [these contributors](../../graphs/contributors).

## License

MIT License. See [LICENSE](LICENSE) for full details.
