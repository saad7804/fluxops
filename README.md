# FluxOps – Continuous and Automated IT Operations

**FluxOps** is an educational DevOps command and deployment assistant designed to help students and beginners understand common DevOps tools and workflows.

It provides reference commands, explanations, examples, learning paths, and deployment guides for Linux, Git, Docker, Jenkins, AWS CLI, and Kubernetes.

The project also demonstrates a practical CI/CD workflow using **Jenkins, Docker, Docker Hub, and Kubernetes (Minikube)**.

> **Note:** FluxOps is a frontend learning application. It does not execute terminal commands or directly manage cloud infrastructure. All commands are provided as references for users to run manually.

---

## Table of Contents

- [Project Overview](#project-overview)
- [Features](#features)
- [Technology Stack](#technology-stack)
- [Project Structure](#project-structure)
- [Application Setup](#application-setup)
- [Docker Containerization](#docker-containerization)
- [AWS EC2 Deployment](#aws-ec2-deployment)
- [Kubernetes Deployment](#kubernetes-deployment)
- [Jenkins CI/CD Pipeline](#jenkins-cicd-pipeline)
- [GitHub Webhook Configuration](#github-webhook-configuration)
- [Troubleshooting](#troubleshooting)
- [Project Results](#project-results)
- [Learning Outcomes](#learning-outcomes)
- [Future Enhancements](#future-enhancements)

---

## Project Overview

FluxOps combines a DevOps learning platform with a practical deployment workflow.

The frontend provides an organized collection of commonly used DevOps commands and guides. The application is containerized using Docker and deployed to Kubernetes.

Jenkins automates the CI/CD process whenever new code is pushed to the GitHub repository.

### Project Workflow

```text
Developer
    |
    v
GitHub Repository
    |
    | Push Event
    v
GitHub Webhook
    |
    v
Jenkins Pipeline
    |
    v
Docker Login
    |
    v
Build Docker Image
    |
    v
Push Image to Docker Hub
    |
    v
Deploy to Kubernetes
    |
    v
Verify Deployment
    |
    v
FluxOps Application
```

---

## Features

### Learning Platform

- DevOps command reference for Linux, Git, Docker, Jenkins, AWS CLI, and Kubernetes.
- Search and filter commands.
- Copy commands directly.
- Save frequently used commands.
- Track learning progress.
- Structured learning paths.
- Docker and EC2 deployment guides.
- Troubleshooting references.
- Responsive user interface.
- Dark and light mode.

### Application Pages

| Page | Description |
|---|---|
| Home | Project overview and navigation |
| Commands | DevOps command reference |
| Docker Guide | Docker concepts and commands |
| EC2 Guide | AWS EC2 deployment guide |
| Learning Paths | Structured learning modules |
| Saved Commands | Bookmarked commands |
| About | Project information |

---

## Technology Stack

| Category | Technologies |
|---|---|
| Frontend | React, TypeScript |
| Build Tool | Vite |
| Styling | Tailwind CSS |
| Routing | React Router |
| Icons | Lucide React |
| Browser Storage | LocalStorage |
| Version Control | Git and GitHub |
| Containerization | Docker |
| Container Registry | Docker Hub |
| CI/CD | Jenkins |
| Cloud Platform | AWS EC2 |
| Orchestration | Kubernetes |
| Kubernetes Environment | Minikube |
| Operating System | Ubuntu Linux |

### Project Does Not Use

- Supabase
- Firebase
- External database
- Backend authentication
- Paid APIs

The frontend stores saved commands and learning progress locally using LocalStorage.

---

## Project Structure

```text
fluxops/
│
├── public/
│
├── src/
│   ├── components/
│   ├── pages/
│   ├── data/
│   ├── hooks/
│   ├── assets/
│   ├── App.tsx
│   └── main.tsx
│
├── screenshots/
│
├── Dockerfile
├── deployment.yml
├── service.yml
├── Jenkinsfile
├── package.json
├── package-lock.json
├── vite.config.ts
├── tsconfig.json
└── README.md
```

---

## Application Setup

### Prerequisites

- Node.js
- npm
- Git

### Clone Repository

```bash
git clone https://github.com/saad7804/fluxops.git
```

```bash
cd fluxops
```

### Install Dependencies

```bash
npm install
```

### Start Development Server

```bash
npm run dev
```

Open the application in your browser using the local URL displayed by Vite.

### Build Application

```bash
npm run build
```

The production build is generated inside the `dist/` directory.

---

## Docker Containerization

The application is containerized using a multi-stage Docker build.

### Dockerfile

The Dockerfile uses:

- `node:20-alpine` for building the React application.
- `nginx:alpine` for serving the production build.
- Port `80` for HTTP traffic.

### Build Docker Image

```bash
docker build -t saadmomin7804/fluxops:latest .
```

### Run Container

```bash
docker run -d -p 80:80 --name fluxops saadmomin7804/fluxops:latest
```

### Verify Container

```bash
docker ps
```

### Access Application

```text
http://localhost
```

### Docker Hub Repository

[https://hub.docker.com/r/saadmomin7804/fluxops](https://hub.docker.com/r/saadmomin7804/fluxops)

---

## AWS EC2 Deployment

The application can be hosted on an Ubuntu EC2 instance.

### Prerequisites

- AWS EC2 Ubuntu instance.
- Security group allowing SSH (22) and HTTP (80).
- Git installed.
- Docker installed.

### Clone Repository

```bash
git clone https://github.com/saad7804/fluxops.git
cd fluxops
```

### Build Docker Image

```bash
docker build -t fluxops .
```

### Run Application

```bash
docker run -d -p 80:80 --name fluxops fluxops
```

Access the application using:

```text
http://YOUR_EC2_PUBLIC_IP
```

---

## Kubernetes Deployment

The application is deployed to a Kubernetes cluster using Minikube.

### Kubernetes Configuration

| Component | Configuration |
|---|---|
| Namespace | fluxops |
| Deployment | fluxops |
| Service | fluxops-service |
| Replicas | 2 |
| Container Port | 80 |
| Service Type | NodePort |
| NodePort | 30007 |
| Image | saadmomin7804/fluxops:latest |

### Create Namespace

```bash
kubectl create namespace fluxops
```

### Deploy Application

```bash
kubectl apply -f deployment.yml
```

```bash
kubectl apply -f service.yml
```

### Verify Deployment

```bash
kubectl get pods -n fluxops
```

```bash
kubectl get deployments -n fluxops
```

```bash
kubectl get services -n fluxops
```

### Access Application

To access the application through port forwarding:

```bash
kubectl port-forward \
  --address 0.0.0.0 \
  service/fluxops-service \
  9090:80 \
  -n fluxops
```

Open:

```text
http://YOUR_EC2_PUBLIC_IP:9090
```

Ensure the EC2 security group allows inbound traffic on port `9090`.

---

## Jenkins CI/CD Pipeline

Jenkins automates the build, containerization, image publishing, and Kubernetes deployment process.

The pipeline is configured using a `Jenkinsfile` stored in the GitHub repository.

### Jenkins Pipeline Job

**Job Name:** `fluxops-pipeline`

### Pipeline Stages

| Stage | Description |
|---|---|
| Checkout Code | Retrieves the latest source code from GitHub |
| Docker Login | Authenticates with Docker Hub |
| Build Docker Image | Builds the application Docker image |
| Push Docker Image | Pushes the image to Docker Hub |
| Deploy to Kubernetes | Applies Kubernetes deployment and service configurations |
| Verify Deployment | Checks pods, services, and deployment status |

### Pipeline Process

**1. Code Checkout**

Jenkins retrieves the latest code from the GitHub repository.

**2. Docker Authentication**

Jenkins authenticates with Docker Hub using stored credentials.

**3. Docker Image Build**

The application is packaged into a Docker image.

**4. Push to Docker Hub**

The newly built image is pushed to the Docker Hub repository.

**5. Kubernetes Deployment**

Jenkins applies the Kubernetes deployment and service manifests.

It also restarts the deployment to ensure the updated image is used.

**6. Deployment Verification**

Jenkins checks the rollout status and verifies the Kubernetes resources.

### Jenkins Credentials

The following credentials are configured in Jenkins:

| Credential ID | Type | Purpose |
|---|---|---|
| `docker_creds` | Username with password | Docker Hub authentication |
| `kubeconfig` | Secret file | Kubernetes cluster access |

Sensitive credentials are stored in Jenkins and are not hardcoded in the repository.

### Pipeline Commands

The pipeline uses commands such as:

```bash
kubectl create namespace fluxops --dry-run=client -o yaml | kubectl apply -f -
```

```bash
kubectl apply -f deployment.yml
```

```bash
kubectl apply -f service.yml
```

```bash
kubectl rollout restart deployment/fluxops -n fluxops
```

```bash
kubectl rollout status deployment/fluxops -n fluxops
```

### Deployment Verification

```bash
kubectl get pods -n fluxops
```

```bash
kubectl get services -n fluxops
```

```bash
kubectl get deployments -n fluxops
```

```bash
kubectl get all -n fluxops
```

---

## GitHub Webhook Configuration

A GitHub webhook is configured to trigger the Jenkins pipeline automatically when code is pushed to the repository.

### Configuration

1. Open the GitHub repository.
2. Navigate to **Settings → Webhooks**.
3. Select **Add webhook**.
4. Enter the Jenkins webhook endpoint:

```text
http://YOUR_JENKINS_PUBLIC_IP:8080/github-webhook/
```

5. Select `application/json` as the content type.
6. Enable the **Just the push event** option.
7. Save the webhook.

Jenkins must be accessible from GitHub for webhook delivery to work.

### Automated Workflow

```text
Code Change
    |
    v
Git Push
    |
    v
GitHub Webhook
    |
    v
Jenkins Triggered
    |
    v
Docker Image Built
    |
    v
Image Pushed to Docker Hub
    |
    v
Kubernetes Deployment Updated
    |
    v
Deployment Verified
```

---

## Troubleshooting

### Docker Permission Denied

```bash
sudo usermod -aG docker $USER
```

Log out and log in again for the group change to take effect.

### Port Already in Use

Check which process is using port 80:

```bash
sudo lsof -i :80
```

### Container Name Already Exists

```bash
docker rm -f fluxops
```

### Check Docker Containers

```bash
docker ps -a
```

### Kubernetes Pods Not Running

```bash
kubectl get pods -n fluxops
```

```bash
kubectl describe pods -n fluxops
```

### Check Kubernetes Services

```bash
kubectl get svc -n fluxops
```

### Check Deployment Events

```bash
kubectl describe deployment fluxops -n fluxops
```

### Check Application Logs

```bash
kubectl logs -l app=fluxops -n fluxops
```

### Check Disk Usage

```bash
docker system df
```

Be careful when using `docker system prune -a`, as it can remove unused images and build cache.

---

## Project Results

The project demonstrates the following:

- Developed a React-based DevOps learning application.
- Managed source code using Git and GitHub.
- Containerized the application using Docker.
- Published Docker images to Docker Hub.
- Hosted the application on AWS EC2.
- Configured Jenkins for automated CI/CD.
- Integrated GitHub webhooks with Jenkins.
- Deployed the application to Kubernetes using Minikube.
- Configured a Kubernetes namespace, deployment, and service.
- Ran the application with two replicas.
- Verified deployment and rollout status using `kubectl`.

---

## Learning Outcomes

Through this project, I gained practical experience with:

- Git and GitHub version control.
- Linux and Ubuntu administration.
- Docker image creation and container management.
- Docker Hub image publishing.
- Jenkins pipeline configuration.
- Jenkins credentials management.
- CI/CD automation.
- GitHub webhook integration.
- Kubernetes deployments and services.
- Minikube cluster management.
- AWS EC2 deployment.
- Troubleshooting container and Kubernetes workloads.

---

## Future Enhancements

- Implement version-based Docker image tagging.
- Add automated application testing.
- Integrate code quality and security scanning.
- Add application monitoring and logging.
- Configure Kubernetes Ingress.
- Enable HTTPS.
- Implement automated rollback.
- Expand the DevOps learning modules.

---

## Author

**Saad Momin**

- GitHub: [github.com/saad7804](https://github.com/saad7804)
- LinkedIn: [linkedin.com/in/saadmomin](https://linkedin.com/in/saadmomin)

---

## Conclusion.

FluxOps combines a practical DevOps learning application with an automated CI/CD deployment workflow.

The project demonstrates how GitHub, Jenkins, Docker, Docker Hub, AWS EC2, and Kubernetes can work together to automate application delivery.

It helped me gain hands-on experience with containerization, CI/CD automation, Kubernetes deployment, and infrastructure troubleshooting.

**Project Repository:** [https://github.com/saad7804/fluxops](https://github.com/saad7804/fluxops)
