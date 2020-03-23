eksctl create cluster --name simple-jwt-api

$env:ACCOUNT_ID = aws sts get-caller-identity --query Account --output text

$env:TRUST = "{ \`"Version\`": \`"2012-10-17\`", \`"Statement\`": [ { \`"Effect\`": \`"Allow\`", \`"Principal\`": { \`"AWS\`": \`"arn:aws:iam::${env:ACCOUNT_ID}:root\`" }, \`"Action\`": \`"sts:AssumeRole\`" } ] }"

aws iam create-role --role-name UdacityFlaskDeployCBRole --assume-role-policy-document "$env:TRUST" --output text --query 'Role.Arn'

echo '{ "Version": "2012-10-17", "Statement": [ { "Effect": "Allow", "Action": [ "eks:Describe*", "ssm:GetParameters" ], "Resource": "*" } ] }' > $env:C:\Users\Tailin\Desktop\FSND-Deploy-Flask-App-to-Kubernetes-Using-EKS\iam-role-policy

aws iam put-role-policy --role-name UdacityFlaskDeployCBRole --policy-name eks-describe --policy-document file://$env:C:\Users\Tailin\Desktop\FSND-Deploy-Flask-App-to-Kubernetes-Using-EKS\iam-role-policy

kubectl get -n kube-system configmap/aws-auth -o yaml > $env:C:\Users\Tailin\Desktop\FSND-Deploy-Flask-App-to-Kubernetes-Using-EKS\aws-auth-patch.yml

kubectl patch configmap/aws-auth -n kube-system --patch $(Get-Content $env:C:\Users\Tailin\Desktop\FSND-Deploy-Flask-App-to-Kubernetes-Using-EKS\aws-auth-patch.yml -Raw)