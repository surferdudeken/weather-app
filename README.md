- Instructions: 
    *  aws eks update-kubeconfig --region us-east-2 --name weather-microservice
    * kubectl create namespace jenkins
    * kubectl apply -f jenkins-deployment.yml -n jenkins
    * kubectl apply -f jenkins-lb.yml -n jenkins
    * kubectl get svc jenkins -n jenkins
    * POD_NAME=$(kubectl get pods -l app=jenkins -n jenkins -o jsonpath="{.items[0].metadata.name}")
    * kubectl logs $POD_NAME -n jenkins | grep -A 5 "Jenkins initial setup is required"



- Installs:
    - curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3
    - curl -LO "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl"
    - curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"

- Resources: 
    - https://registry.terraform.io/modules/terraform-aws-modules/eks/aws/latest
    - https://api.open-meteo.com/v1/forecast?latitude=38.8951&longitude=-77.0364&daily=temperature_2m_max,temperature_2m_min,precipitation_sum&temperature_unit=fahrenheit&windspeed_unit=mph&precipitation_unit=inch&timezone=GMT'
    - https://www.fullstackpython.com/flask-json-jsonify-examples.html
    - https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/data-sources/storage_class
    - https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs
    - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_cluster


    - https://helm.sh/docs/


- weather-app/source/ref/output_rf
    - Output to get understanding what the set up is doing
    - grabbed eks.node_secuirty_id so it could be set dynmaiclly vs statically