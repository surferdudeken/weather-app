pipeline {
    agent {
        node {
            label 'build-agent'
        }
    }
    stages {
        stage('Debug Directory Structure') {
            steps {
                sh 'echo "Current Directory: $PWD"'
                sh 'ls -al'
            }
        }

        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        
        stage('Podman Login') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', passwordVariable: 'DOCKER_PASSWORD', usernameVariable: 'DOCKER_USERNAME')]) {
                    sh '''#!/bin/bash
                          echo $DOCKER_PASSWORD | podman login docker.io -u $DOCKER_USERNAME --password-stdin
                    '''
                }
            }
        }

        stage('Build and Tag with Podman') {
            steps {
                dir('source') {
                    sh 'podman build -t weather-app:latest .'
                    sh 'podman tag weather-app:latest kabaker/weather-app:latest'
                }
            }
        }
        
        stage('Push Image to Registry') {
            steps {
                dir('source') {
                    sh 'podman push kabaker/weather-app:latest'
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                dir('kub') {
                    script {
                        def returnStatus = sh(script: 'kubectl delete -f weather-app-deployment.yml', returnStatus: true)
                        if (returnStatus != 0) {
                            echo "Deletion of weather-app-deployment.yml failed or it does not exist. Continuing..."
                        }

                        returnStatus = sh(script: 'kubectl delete -f weather-app-lb.yml', returnStatus: true)
                        if (returnStatus != 0) {
                            echo "Deletion of weather-app-lb.yml failed or it does not exist. Continuing..."
                        }
                    }
                    sh 'kubectl apply -f weather-app-deployment.yml'
                    sh 'kubectl apply -f weather-app-lb.yml'
                }
            }
        }
        
        stage('Output Weather App URL') {
            steps {
                echo "Fetching the Weather App URL..."
                sh '''#!/bin/bash
                  sleep 45
                  URL=$(kubectl get svc weather-app-service -o=jsonpath='{.status.loadBalancer.ingress[0].hostname}')
                  echo "Weather App URL: ${URL}/weather-app"
                '''
            }
        }
    }
}
