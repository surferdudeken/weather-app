#!/bin/bash

cd terraform
terraform init
terraform apply -auto-approve

aws eks update-kubeconfig --region us-east-2 --name weather-microservice
kubectl create namespace jenkins
kubectl apply -f ../kub/jenkins-deployment.yml -n jenkins
kubectl apply -f ../kub/jenkins-lb.yml -n jenkins

# cd ../source/
# podman build -t weather-app:latest .
clear 

echo "Waiting for Jenkins to be accessible..."
sleep 180 
JENKINS_IP=$(kubectl get svc jenkins -o jsonpath='{.status.loadBalancer.ingress[0].ip}')
echo "Jenkins should be accessible at: http://${JENKINS_IP}:8080"

POD_NAME=$(kubectl get pods -l app=jenkins -n jenkins -o jsonpath="{.items[0].metadata.name}")
PASSWORD=$(kubectl logs $POD_NAME -n jenkins | grep -A 5 "Jenkins initial setup is required")

echo $PASSWORD
echo "Please configure changes as per the README.md file" 