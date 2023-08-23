Manual Work (management console aka build-agent): 
    1. Create a ec2 instance calls "management console" this is where we will host our tf code 
    2. In the "management console" as ec2-user run: 
        - dnf install git
        - git clone https://github.com/surferdudeken/weather-app.git
        - run weather-app/package_dep.sh (installs dependecies needed)
        - After completing the "aws configure" step 
        - Run weather-app/initial_setup.sh (Will setup jenkins in the eks cluster)
        - Save the output of the load balancer ip and password
            

Jenkins agent set up: 
    1. Jenkins build agent (in our case it's the managment console that our bash script was ran)
    2. Go to Dashboard > Manage Jenkins > Nodes >

S3 bucket setup for terraform: 
    1. Setup a s3 bucket named "s3tfstateohio" or use local machine 
            terraform {
            backend "s3" {
                bucket = "s3tfstateohio"
                key    = "weather-microservice.tfstate"
                region = "us-east-2"
            }
            }


    
        

- Instructions: 
    *  aws eks update-kubeconfig --region us-east-2 --name weather-microservice
    * kubectl create namespace jenkins
    * kubectl apply -f jenkins-deployment.yml -n jenkins
    * kubectl apply -f jenkins-lb.yml -n jenkins
    * kubectl get svc jenkins -n jenkins
    * POD_NAME=$(kubectl get pods -l app=jenkins -n jenkins -o jsonpath="{.items[0].metadata.name}")
    * kubectl logs $POD_NAME -n jenkins | grep -A 5 "Jenkins initial setup is required"

- Resources: 
    - https://registry.terraform.io/modules/terraform-aws-modules/eks/aws/latest
    - https://api.open-meteo.com/v1/forecast?latitude=38.8951&longitude=-77.0364&daily=temperature_2m_max,temperature_2m_min,precipitation_sum&temperature_unit=fahrenheit&windspeed_unit=mph&precipitation_unit=inch&timezone=GMT'
    - https://www.fullstackpython.com/flask-json-jsonify-examples.html
    - https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/data-sources/storage_class
    - https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs
    - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_cluster
    - https://stackoverflow.com/questions/1117398/java-home-directory-in-linux
    - https://kubernetes.io/docs/reference/kubectl/#output-options
    - https://kubernetes.io/docs/reference/kubectl/cheatsheet/


- weather-app/source/ref/output_rf
    - Output to get understanding what the set up is doing
    - grabbed eks.node_secuirty_id so it could be set dynmaiclly vs statically


    podman build -t weather-app .
podman tag weather-app kabaker/weather-app:latest
podman push kabaker/weather-app:latest
