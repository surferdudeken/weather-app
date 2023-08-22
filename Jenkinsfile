pipeline {
    agent {
        node {
            label 'build-agent'
        }
    }
    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        
        stage('Build with Podman') {
            steps {
                dir('weather-app/source') {
                    sh 'podman build -t weather-app:latest .'
                }
            }
        }
        
        stage('Push Image to Registry') {
            steps {
                dir('weather-app/source') {
                    sh 'podman push weather-app:latest 3.145.173.195:6000/weather-app:latest'
                }
            }
        }

        stage('Update Deployment File') {
            steps {
                dir('weather-app/kub') {
                    sh 'sed -i "s|[DOCKER_IMAGE_FOR_WEATHER_APP]|3.145.173.195:6000/weather-app:latest|g" weather-app-deployment.yml'
                }
            }
        }
        
        stage('Deploy to Kubernetes') {
            steps {
                dir('weather-app/kub') {
                    sh 'kubectl apply -f weather-app-deployment.yml'
                    sh 'kubectl apply -f weather-app-lb.yml'
                }
            }
        }
        
        stage('Output Weather App URL') {
            steps {
                echo "Fetching the Weather App URL..."
                sh '''#!/bin/bash
                  URL=$(kubectl get svc weather-app-service -o=jsonpath='{.status.loadBalancer.ingress[0].hostname}')
                  echo "Weather App URL: $URL"
                '''
            }
        }
    }
}