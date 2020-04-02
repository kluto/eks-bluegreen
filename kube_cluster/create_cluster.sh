eksctl create cluster \
--name=big-cheese \
--region=us-west-2 \
--kubeconfig=/var/lib/jenkins/.kube/config \
--nodes=2 \
--node-type= t2.micro \
--nodes-min=2 \
--nodes-max=5