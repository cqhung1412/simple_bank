#### Steps

- Deploy EKS Cluster

```cmd
aws cloudformation deploy \
--s3-bucket eks-cloudformation-artifact-bucket \
--template-file aws/cloudformation/eks-cluster.yaml \
--stack-name simple-bank-cluster \
--capabilities CAPABILITY_NAMED_IAM \
--no-fail-on-empty-changeset \
--tags \
        Name='Kube Cluster'
```

- Get .kubeconfig file

```cmd
aws eks update-kubeconfig --region region-code --name generated-cluster-name
```

- Deploy EKS addon

```cmd
aws cloudformation deploy \
    --s3-bucket eks-cloudformation-artifact-bucket \
    --template-file aws/cloudformation/eks-addon.yaml \
    --stack-name simple-bank-eks-addons \
    --capabilities CAPABILITY_NAMED_IAM \
    --no-fail-on-empty-changeset \
    --tags \
        Name='Kube Cluster Resources - EKS Addons'
```

- Deploy EKS Nodegroup

```cmd
aws cloudformation deploy \
  --s3-bucket eks-cloudformation-artifact-bucket \
  --template-file aws/cloudformation/eks-nodegroup.yaml \
  --stack-name simple-bank-nodegroup \
  --capabilities CAPABILITY_NAMED_IAM \
  --no-fail-on-empty-changeset \
  --tags \
      Name='Kubernetes Cluster Resources - Worker Nodes'
```
