# Disney+ Hotstar Clone – DevSecOps CI/CD Pipeline

## Project Overview
This project demonstrates a complete **DevSecOps CI/CD pipeline** for deploying a Disney+ Hotstar Clone application using modern DevOps and Cloud technologies.
The pipeline automates:
* Source code management
* Continuous Integration
* Security scanning
* Docker image build
* Kubernetes deployment
* Monitoring and alerting
* Infrastructure provisioning
---
# Architecture Diagram
<img width="1619" height="971" alt="project1" src="https://github.com/user-attachments/assets/f5c8a865-306f-432c-890d-97626432d40f" />

## Workflow

1. Developer pushes code to GitHub
2. Jenkins pipeline gets triggered
3. SonarQube performs code quality analysis
4. NPM installs dependencies
5. Trivy scans filesystem vulnerabilities
6. Docker image is built
7. Trivy scans Docker image
8. Docker image is pushed to registry
9. Application is deployed to Kubernetes
10. Cloudflare + Load Balancer expose the application
11. Prometheus and Grafana monitor the infrastructure
12. Email notifications are sent through Gmail

---
## DevOps Tools

* GitHub
* Jenkins
* SonarQube
* Docker
* Kubernetes
* Terraform
* Trivy
* Prometheus
* Grafana
* Cloudflare
* Jira
## Cloud & Infrastructure
* AWS EC2
* AWS Load Balancer
* Kubernetes Cluster
* Docker Registry

## Application Stack

* Node.js
* React.js
* NPM

---
# Features

* Complete CI/CD Automation
* Infrastructure as Code using Terraform
* Docker Containerization
* Kubernetes Deployment
* Security Scanning with Trivy
* Code Quality Analysis using SonarQube
* Monitoring with Prometheus & Grafana
* SSL and DNS via Cloudflare
* Jenkins Email Notifications
* Scalable Production Deployment

---
# Project Structure

```bash
.
├── Jenkinsfile
├── terraform/
├── kubernetes/
├── docker/
├── src/
├── package.json
├── deployment.yaml
├── service.yaml
└── README.md
```

---
# Prerequisites

Before starting, install the following:
* Git
* Docker
* Kubernetes Cluster
* Jenkins
* Terraform
* Node.js
* SonarQube
* Trivy
* AWS CLI
* kubectl

---
# Step 1 – Clone Repository

```bash
git clone https://github.com/jitendar6486/hotstar-clone-devsecops.git
cd hotstar-clone-devsecops
```

---
# Step 2 – Configure Jenkins

## Install Required Plugins

* Docker Pipeline
* Kubernetes
* SonarQube Scanner
* Email Extension Plugin
* Pipeline Plugin
* Git Plugin

## Configure Tools

Go to:

```text
Manage Jenkins → Global Tool Configuration
```

Configure:

* JDK
* NodeJS
* SonarQube Scanner
* Docker

---

# Step 3 – SonarQube Setup

## Run SonarQube Container

```bash
docker run -d --name sonar -p 9000:9000 sonarqube:lts-community
```

Access:

```text
http://<server-ip>:9000
```

Generate token and add it to Jenkins credentials.

---

# Step 4 – Install Trivy

```bash
sudo apt-get install wget apt-transport-https gnupg lsb-release -y
wget -qO - https://aquasecurity.github.io/trivy-repo/deb/public.key | sudo apt-key add -
echo deb https://aquasecurity.github.io/trivy-repo/deb $(lsb_release -sc) main | sudo tee -a /etc/apt/sources.list.d/trivy.list
sudo apt-get update
sudo apt-get install trivy -y
```

---

# Step 5 – Docker Build

## Build Docker Image

```bash
docker build -t hotstar-clone .
```

## Run Container

```bash
docker run -d -p 3000:3000 hotstar-clone
```

---

# Step 6 – Trivy Scan

## Filesystem Scan

```bash
trivy fs .
```

## Docker Image Scan

```bash
trivy image hotstar-clone
```

---

# Step 7 – Push Docker Image

```bash
docker tag hotstar-clone your-dockerhub-username/hotstar-clone:latest
docker push your-dockerhub-username/hotstar-clone:latest
```

---

# Step 8 – Kubernetes Deployment

## Apply Deployment

```bash
kubectl apply -f deployment.yaml
kubectl apply -f service.yaml
```

## Verify Pods

```bash
kubectl get pods
kubectl get svc
```

---

# Step 9 – Terraform Infrastructure

## Initialize Terraform

```bash
terraform init
```

## Validate

```bash
terraform validate
```

## Plan

```bash
terraform plan
```

## Apply

```bash
terraform apply -auto-approve
```

---

# Step 10 – Monitoring Setup

## Install Prometheus

```bash
kubectl apply -f prometheus.yaml
```

## Install Grafana

```bash
kubectl apply -f grafana.yaml
```

Access Grafana dashboard using:

```text
http://<server-ip>:3000
```

---

# Jenkins Pipeline Example

```groovy
pipeline {
    agent any

    stages {

        stage('Git Checkout') {
            steps {
                git 'https://github.com/your-username/repository.git'
            }
        }

        stage('SonarQube Analysis') {
            steps {
                sh 'sonar-scanner'
            }
        }

        stage('Install Dependencies') {
            steps {
                sh 'npm install'
            }
        }

        stage('Trivy File Scan') {
            steps {
                sh 'trivy fs .'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t hotstar-clone .'
            }
        }

        stage('Trivy Image Scan') {
            steps {
                sh 'trivy image hotstar-clone'
            }
        }

        stage('Push Docker Image') {
            steps {
                sh 'docker push your-image-name'
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                sh 'kubectl apply -f deployment.yaml'
            }
        }
    }
}
```

---

# Security Best Practices

* Use Jenkins Credentials Manager
* Enable Kubernetes RBAC
* Scan images regularly using Trivy
* Store secrets securely
* Enable HTTPS using SSL
* Restrict inbound security group rules

---

# Monitoring & Alerts

## Prometheus

Used for:

* Cluster monitoring
* Node metrics
* Pod metrics
* Application monitoring

## Grafana

Used for:

* Dashboards
* Real-time visualization
* Alerts
* Performance monitoring

---



