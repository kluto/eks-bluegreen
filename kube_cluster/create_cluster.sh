eksctl create cluster \
--name=big-cheese \
--region=us-west-2 \
--nodes-min=2 \
--nodes-max=5 \
--node-type=t2.micro \
--kubeconfig=/var/lib/jenkins/.kube/config