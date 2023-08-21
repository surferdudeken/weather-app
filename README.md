Configure aws cli to kubectl (note)
    aws eks update-kubeconfig --region us-east-2 --name weather-microservice
    kubectl get nodes

Installs:
    curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3
    curl -LO "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl"
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"

Resources: 
    https://registry.terraform.io/modules/terraform-aws-modules/eks/aws/latest
    https://api.open-meteo.com/v1/forecast?latitude=38.8951&longitude=-77.0364&daily=temperature_2m_max,temperature_2m_min,precipitation_sum&temperature_unit=fahrenheit&windspeed_unit=mph&precipitation_unit=inch&timezone=GMT'
    https://www.fullstackpython.com/flask-json-jsonify-examples.html


DONT REINVENT THE WHEEL     
Helm chart jenkins
    https://charts.jenkins.io/
    https://helm.sh/docs/