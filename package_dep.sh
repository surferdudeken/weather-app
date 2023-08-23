#!/bin/bash
set -e 

if ! sudo dnf install git -y; then
    echo "Error installing git. Exiting."
    exit 1
fi

if ! sudo dnf install -y java-11-openjdk; then
    echo "Error installing Java. Exiting."
    exit 1
fi

if ! sudo dnf install -y unzip; then
    echo "Error installing unzip. Exiting."
    exit 1
fi

echo 'export JAVA_HOME=$(dirname $(dirname $(readlink $(readlink $(which java)))))' >> ~/.bash_profile
source ~/.bash_profile

curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
chmod 700 get_helm.sh
if ! ./get_helm.sh; then
    echo "Error installing Helm. Exiting."
    exit 1
fi
rm get_helm.sh

curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
chmod +x kubectl

if ! sudo mv kubectl /usr/local/bin/; then
    echo "Error installing kubectl. Exiting."
    exit 1
fi

curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip

if aws --version &> /dev/null; then
    echo "AWS CLI is already installed. Updating..."
    if ! sudo ./aws/install --update; then
        echo "Error updating AWS CLI. Exiting."
        exit 1
    fi
else
    if ! sudo ./aws/install; then
        echo "Error installing AWS CLI. Exiting."
        exit 1
    fi
fi

rm -rf aws awscliv2.zip

if ! sudo dnf -y install podman; then
    echo "Error installing podman. Exiting."
    exit 1
fi

sudo dnf install -y dnf-plugins-core
sudo dnf config-manager --add-repo=https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo
if ! sudo dnf -y install terraform; then
    echo "Error installing terraform. Exiting."
    exit 1
fi

echo "All tools have been installed!"
echo "Please run aws configure"