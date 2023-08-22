#!/bin/bash

cd weather-app/terraform
terraform init
terraform apply -auto-approve

kubectl apply -f ../kub/jenkins-deployment.yml
kubectl apply -f ../kub/jenkin-lb.yml

cd ../source/
podman build -t weather-app:latest .

echo "Waiting for Jenkins to be accessible..."
sleep 180 
JENKINS_IP=$(kubectl get svc jenkins -o jsonpath='{.status.loadBalancer.ingress[0].ip}')
echo "Jenkins should be accessible at: http://${JENKINS_IP}:8080"
