## CI/CD pipeline for blue/green deployment

Pipeline
 - repo change initates build
 - linter checks for errors
 - blue and green versions of the app are contenerised and pushed to docker hub
 - blue and green versions of the app are deployed with kubernetes
 - load balancers directs traffic to one version only
 
The EKS clusters are provisioned by CloudFormation via eksctl, the official CLI for Amazon EKS.
*Note that if a build fails (bad IAM congfig, etc) the CloudFormation stack needs to be deleted separately, just like with standalone CF scripts.*

Jenkins is used for the automation server.
